const axios = require("axios");
const cds = require("@sap/cds");
const xsenv = require("@sap/xsenv");
const { _dumpCaughtError } = require("./util");

//Load config parameters from package.json
const conf = cds.env.appconfig;

//Connection parameter to IDP
const IAS_SERVICE = conf.IASService;
const IAS_CREDENTIALS = Buffer.from(`${conf.IASUser}:${conf.IASPasswd}`, 'utf8').toString('base64');
const DEFAULT_ROLE = conf.defaultRole;
const INITIAL_PASSWD = conf.initialPasswd;
const ORIGIN = conf.ORIGIN;

//Connection to BTP management API
const XSUAA = xsenv.getServices({ xsuaa: { name: 'ExtUserReg-service-apiaccess' } }).xsuaa;


class UserCreation {
    static async afterEntityUpdateEvent(data, request) {
        const userCreationImpl = new UserCreationImpl();
        await userCreationImpl.afterEntityUpdate(data, request);
        await userCreationImpl.afterUserCreated();
    }
}

module.exports = UserCreation;

class UserCreationImpl {
    constructor(data, request) {
        this.userFromDB = {};
        const messages = [];
        if (!IAS_SERVICE) {
            messages.push("[UC] Missing IAS Service configuration. Please provide IAS_SERIVCE URL in appconfig");
        }
        if (!IAS_CREDENTIALS) {
            messages.push("[UC] Missing IAS Credentials configuration. Please provide IASUser and IASPasswd in appconfig");
        }
        if (!DEFAULT_ROLE) {
            messages.push("[UC] Missing default role configuration. Please provide defaultRole in appconfig");
        }
        if (!INITIAL_PASSWD) {
            messages.push("[UC] Missing initial password configuration. Please provide initialPasswd in appconfig");
        }
        if (!ORIGIN) {
            messages.push("[UC] Missing idp origin name configuration. Please provide ORIGIN in appconfig");
        }
        if (!XSUAA) {
            messages.push("[UC] Missing apiaccess binding to ExtUserReg-service-apiaccess. Please provide respective instance binding in xsenv");
        }
        if (messages.length>0) {
            console.error(messages);
            throw("Error in configuration! Check logs for details");
        }
    }

    async afterEntityUpdate(userdata, request) {
        
        if (!request) {
            console.error("[UC] Missing request parameter");
            return;
        }

        console.debug('[UC] The user creation process started');
        request.on('succeeded', async () => {
            try {
                console.debug('[UC] Status is ' + userdata.Status);
                if (userdata.Status === "A") { //Only approved requests will be handeled

                    console.debug('[UC] Creating user on IAS');
                    console.debug('[UC] Data' + JSON.stringify(userdata));

                    //read all user data from DB
                    this.userFromDB = await cds.run(SELECT.one.from(`ExtUserReg.RegistrationRequest`).where({ ID: userdata.ID }));

                    console.debug('[UC] Data from DB:' + JSON.stringify(this.userFromDB));
                    const response = await axios.request({
                        url: IAS_SERVICE + '/scim/Users',
                        method: "post",
                        data: {
                            "schemas": [
                                "urn:ietf:params:scim:schemas:core:2.0:User",
                                "urn:ietf:params:scim:schemas:extension:sap:2.0:User"
                            ],
                            "userName": this.userFromDB.Email,
                            "name": {
                                "familyName": this.userFromDB.Lastname,
                                "givenName": this.userFromDB.Firstname
                            },
                            "password": INITIAL_PASSWD,
                            "active": true,
                            "displayName": this.userFromDB.Firstname + '' + this.userFromDB.Lastname,
                            "userType": "partner",
                            "emails": [
                                {
                                    "value": this.userFromDB.Email,
                                    "type": "work",
                                    "primary": true
                                }
                            ],
                            "urn:ietf:params:scim:schemas:extension:sap:2.0:User":
                            {
                                "sendMail": false,
                                "mailVerified": true,
                                "passwordDetails": {
                                    "status": "enabled"
                                }
                            }
                        },
                        headers: {
                            "Authorization": `BASIC ${IAS_CREDENTIALS}`,
                            'Content-Type': 'application/scim+json'
                        },
                    });
                    if (response.status === 201) {
                        console.debug('[UC] User created successfully at: ' + response.headers['location']);
                        console.debug('[UC] User created with ID:' + response.data.id);

                    } else {
                        console.debug('[UC] User creation failed with:' + JSON.stringify(response));
                    }
                }
            } catch (error) {
                _dumpCaughtError(error);
            }
        });
    }
    async afterUserCreated() {
       
        console.debug("[BTP API] Add shadow user to BAS Developer Group");
        try {
            const accessToken = await this.getOauthToken();
            console.debug('[BTP API] Accesstoken:' + (accessToken === null || accessToken.trim() === "") ? "not available" : "successfully retrieved");
            if (!accessToken) {
                return;
            }
            
            var shadowUserID = "";
            //Create shadow user
            const createResponse = await axios.request(
                {
                    url: XSUAA.apiurl + '/Users',
                    method: "post",
                    data: {
                        "userName": this.userFromDB.Email,
                        "name": {
                            "familyName": this.userFromDB.Lastname,
                            "givenName": this.userFromDB.Firstname
                        },
                        "emails": [
                            {
                                "value": this.userFromDB.Email,
                                "primary": true
                            }
                        ],
                        "approvals": [],
                        "active": true,
                        "verified": true,
                        "origin": ORIGIN,
                        "schemas": [
                            "urn:scim:schemas:core:1.0"
                        ]
                    },
                    headers: {
                        "Authorization": `Bearer ${accessToken}`,
                        "Content-Type": 'application/json'
                    }
                }
            )
            if (createResponse.status === 201) {
                shadowUserID = createResponse.data.id;
                console.debug('[BTP API] Shadow user successfully created.');
            } else {
                console.error('[BTP API]' + JSON.stringify(groupResponse));
                return;
            }

            //Assign role to user
            const groupResponse = await axios.request(
                {
                    url: XSUAA.apiurl + `/Groups/${DEFAULT_ROLE}/members`,
                    method: "post",
                    data: {
                        "origin": `${ORIGIN}`,
                        "type": "USER",
                        "value": shadowUserID
                    },
                    headers: {
                        "Authorization": `Bearer ${accessToken}`,
                        "Content-Type": 'application/json'
                    }
                }
            )
            if (groupResponse.status === 201) {
                console.debug('[BTP API] User successfully added to group.');
            } else {
                console.debug('[BTP API] Could not add role to user' + JSON.stringify(groupResponse));
            }
        } catch (error) {
            _dumpCaughtError(error);
        }
    }

    async getOauthToken() {
        const params = {
            client_id: XSUAA.clientid,
            client_secret: XSUAA.clientsecret,
            grant_type: 'client_credentials',
            response_type: 'token'
        };

        const data = Object.keys(params)
            .map((key) => `${key}=${encodeURIComponent(params[key])}`)
            .join('&');


        try {
            console.debug("[BTP API] TokenURL:" + JSON.stringify(XSUAA));
            const accessResponse = await axios({
                method: 'post',
                url: XSUAA.url + '/oauth/token',
                data,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Accept': 'application/json'
                }
            });
            return accessResponse.data.access_token;

        } catch (error) {
            console.error(`Error while getting oauth token: ${JSON.stringify(error)}`);
            throw(error);
        }
    }
}


