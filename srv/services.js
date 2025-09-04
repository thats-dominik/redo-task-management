const cds = require('@sap/cds')

class TaskService extends cds.ApplicationService {
  init() {

    this.on('READ', 'UiConfig', (req) => {
      const u = req.user
      const isChef        = u.is('chef')
      const isMitarbeiter = u.is('mitarbeiter')
      const isPraktikant  = u.is('praktikant')

      return {
        ID: 'singleton',
        canUpdate: (isChef || isMitarbeiter) && !isPraktikant, // praktikant=false
        canDelete: isChef                                      // nur chef=true
      }
    })


    this.before('CREATE', 'Tasks', (req) => {
      req.data.creator_ID = req.user.id
      const t = req.data?.title || ''
      if (/urgent/i.test(t)) req.data.urgency_code = 'H'
    })

    this.before('UPDATE', 'Tasks', async (req) => {
      if ('creator_ID' in req.data) delete req.data.creator_ID
      const id = req.data?.ID
      if (!id) return

      const { Tasks } = cds.entities['redo.taskmanager']   // db Entität
      const row = await SELECT.one.from(Tasks).columns('status_code').where({ ID: id })
      if (!row) return

      if (row.status_code === 'D' || row.status_code === 'X') {
        req.reject(400, "Can't modify a closed task (done/canceled).")
      }
    })

    return super.init()
  }
}

module.exports = { TaskService }
