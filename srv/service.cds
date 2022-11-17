using { ExtUserReg as my } from '../db/schema';

@path : 'service/ExtUserReg'
service ExtUserRegService
{
    @insertonly entity RegistrationRequest as
        projection on my.RegistrationRequest
        {
            *
        };
}


service ManageUserRegistrations 
{
    entity RegistrationRequest as
        projection on my.RegistrationRequest
        {
            *
        };
}

annotate RegistrationRequest with @requires: [
    'any'
];

annotate ManageUserRegistrations with @requires :
[
    'authenticated-user'
];
