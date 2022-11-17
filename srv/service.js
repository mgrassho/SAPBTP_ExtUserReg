const cds = require('@sap/cds');
const WorkflowHandler = require('./workflow/WorkflowHandler');
const UserCreation = require('./workflow/UserCreation');


class LCAPApplicationService extends cds.ApplicationService {
  /*
   * Overload init() to register own handlers to be invoked first in the respective phase
   * note: before and after handlers are invoked in parallel!
   */
  async init() {
    cds.env["log-level"] = 'debug';
    console.debug("DEBUG MODE STARTED");  
   
    /**
     * Make sure that each new registration request will trigger a new workflow instance
     */
    this.after('CREATE', "RegistrationRequest", (data, request) => {
        WorkflowHandler.afterEntityCreateEvent(data, request);
    });
    

    /**
     * This will be called when the workflow comes back and updates the status of the entity.
     * UserCreation will check if Status is apptoved ("A") and then will create a user in IAS.
     */
    this.after('UPDATE', "RegistrationRequest", (data,request) => {
        UserCreation.afterEntityUpdateEvent(data,request);
    });

    super.init();
  }
}

module.exports = LCAPApplicationService;

