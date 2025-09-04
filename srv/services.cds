using { redo.taskmanager as my } from '../db/schema';

service TaskService {

  @restrict: [
    { grant: 'READ', to: 'any' },  // TEMP zum Testen
    { grant: ['CREATE','UPDATE'], to: ['praktikant','mitarbeiter','chef'] },
    { grant: 'DELETE', to: ['chef'] }
  ]
  entity Tasks as projection on my.Tasks;

  @readonly entity Users   as projection on my.Users;

}

annotate TaskService.Tasks with @odata.draft.enabled; 
