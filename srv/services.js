const cds = require('@sap/cds')

class TaskService extends cds.ApplicationService {
  init() {

    // CREATE: urgency automatisch auf 'H', wenn "urgent" im Titel
    this.before('CREATE', 'Tasks', (req) => {
      const t = req.data?.title || ''
      if (/urgent/i.test(t)) req.data.urgency_code = 'H'
    })

    // UPDATE: gesperrt, wenn bereits Done (D) oder Canceled (X)
    this.before('UPDATE', 'Tasks', async (req) => {
      const id = req.data?.ID
      if (!id) return

      // aktuellen Status aus der DB lesen (Persistenz-Entität!)
      const { Tasks } = cds.entities['redo.taskmanager']   // db-Entität
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
