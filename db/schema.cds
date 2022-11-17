namespace ExtUserReg;

using
{
    Country,
    Currency,
    Language,
    User,
    cuid,
    extensible,
    managed,
    temporal
}
from '@sap/cds/common';

entity RegistrationRequest
{
    key ID : UUID
        @Core.Computed;
    Firstname : String(100);
    Lastname : String(100);
    CompanyName : String(100);
    CompanyID : String(100);
    Email : String(100);
    Reason : String(600);
    RegistrationDate : Timestamp;
    Status : String(5);
    DecisionDate : DateTime;
}
