const cds = require('@sap/cds')
cds.on('bootstrap', app => {
  app.get('/logout', (req,res) => {
    res.set('WWW-Authenticate','Basic realm="logout"')
    res.status(401).send('Logged out')
  })
  app.get('/login', (req,res) => {                 // erzwingt Login-Prompt
    res.set('WWW-Authenticate','Basic realm="login"')
    res.status(401).send('Login')
  })
  cds.on('bootstrap', app => {
  app.get('/whoami', (req,res)=>{
    res.json({ user: req.user?.id, roles: req.user?.roles })
  })
})

//UI Hidden


})
module.exports = cds.server
cds
