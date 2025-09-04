using { redo.taskmanager as my } from '../db/schema';

@requires: ['praktikant', 'mitarbeiter', 'chef']
service TaskService {

@odata.singleton @cds.persistence.skip
  entity UiConfig {
    key ID     : String;
    canUpdate  : Boolean;
    canDelete  : Boolean; 
  }

  @odata.draft.enabled
  @restrict: [
    { grant: ['READ','CREATE'],                     to: 'praktikant',  where: 'createdBy = $user' },
    { grant: ['READ','CREATE','UPDATE'],            to: 'mitarbeiter' },
    { grant: ['READ','CREATE','UPDATE','DELETE'],   to: 'chef' }
  ]
  entity Tasks as projection on my.Tasks {
    ID, creator, assignee, title, description, urgency, status, dueAt, comments,
    createdAt, createdBy, modifiedAt, modifiedBy
  };


  @readonly entity Users   as projection on my.Users;
  @readonly entity Status  as projection on my.Status;
  @readonly entity Urgency as projection on my.Urgency;
}