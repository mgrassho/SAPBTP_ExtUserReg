
const axios = require("axios");
const xsenv = require('@sap/xsenv');
const { _dumpCaughtError } = require("./util");

//Load config parameters from package.json
const conf = cds.env.appconfig;
const WORKFLOW_DEFINITION_ID = conf.WFDefinitionID;

const WORKFLOW_SERVICE = xsenv.getServices({ "workflow": "ExtUserReg-workflow" }).workflow;
const WORFKLOW_TOKEN_URL = `${WORKFLOW_SERVICE.uaa.url}/oauth/token?grant_type=client_credentials`;
const WORKFLOW_CREDENTIALS = `${WORKFLOW_SERVICE.uaa.clientid}:${WORKFLOW_SERVICE.uaa.clientsecret}`;



class WorkflowHandler {

  static async afterEntityCreateEvent(data, request) {
    const workflowEntityHandler = new WorkflowEntityHandler();
    workflowEntityHandler.afterEntityCreate(data, request);
  }
}

module.exports = WorkflowHandler;

class WorkflowEntityHandler {

  constructor(data, request) {
    const messages = [];

    if (!WORKFLOW_DEFINITION_ID) {
      messages.push('[WF] Missing config parameter in package.json: WFDefinitionID');
    }
    if (!WORKFLOW_SERVICE) {
      messages.push = "[WF] Workflow binging missing. Check availablity of ExtUserReg-workflow in XSENV";
    }
    if (messages.length > 0) {
      console.error(messages);
      throw ("Error in configuration! Check logs for details");
    }
  }

  async afterEntityCreate(data, request) {
    if (!request) {
      console.error('[WF] Missing request parameter');
      return;
    }
    console.debug('[WF] The create workflow entity after event handler is triggerred.');
    request.on('succeeded', async () => {
      try {
        console.debug('[WF] The create workflow entity request succeeded event handler is trigerred.');

        const accessToken = await _getAccessToken(WORKFLOW_SERVICE, request);
        console.debug('[WF] Access token:' + (accessToken === null || accessToken.trim() === "") ? "not available" : "successfully retrieved");
        if (!accessToken) {
          return;
        }
        console.debug('[WF] Starting workflow with definition ID "' + WORKFLOW_DEFINITION_ID + '"...');
        console.debug('[WF] Worflow data:' + JSON.stringify(data));
        const workflowResponse = await axios.request({
          url: WORKFLOW_SERVICE.endpoints.workflow_rest_url + '/v1/workflow-instances',
          method: "post",
          data: {
            "definitionId": WORKFLOW_DEFINITION_ID,
            "context": data
          },
          headers: {
            "Authorization": `Bearer ${accessToken}`,
            'Content-Type': 'application/json'
          },
        });
        if (workflowResponse.status === 201) {
          console.debug('[WF] Workflow "' + workflowResponse.data.id + '" successfully started.');
        } else {
          console.debug(workflowResponse);
          console.error('[WF] Workflow "' + workflowResponse.data.id + '" failed to started (' + workflowResponse.status + ').');
        }

      } catch (error) {
        _dumpCaughtError(error);
      }
    });
  }
}


async function _getAccessToken() {
  try {
    console.debug("[WF AT] TokenURL:" + WORFKLOW_TOKEN_URL);
    console.debug("[WF AT] Cred:" + WORKFLOW_CREDENTIALS);
    const accessResponse = await axios({
      method: 'post',
      url: WORFKLOW_TOKEN_URL,
      headers: {
        Authorization: `Basic ${Buffer.from(WORKFLOW_CREDENTIALS).toString('base64')}`,
      },
    });
    return accessResponse.data.access_token;

  } catch (error) {
    console.error(`Error while starting workflow with id ${WORKFLOW_DEFINITION_ID}: ${JSON.stringify(error)}`);
    throw (error);
  }
}