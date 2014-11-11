require! <[ cluster ]>
cpus = require(\os).cpus!

console.log cpus.length

cluster.setupMaster do
  exec : "lsc process.ls < data/sample.csv"
  # args : ["--use", "https"],
  # silent : true

for let i from 1 to cpus.length
  cluster.fork!

cluster.on \exit, (worker, code, signal) !->
  console.log('worker ' + worker.process.pid + ' died')