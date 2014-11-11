var cluster, cpus, i$, to$;
cluster = require('cluster');
cpus = require('os').cpus();
console.log(cpus.length);
cluster.setupMaster({
  exec: "lsc process.ls < data/sample.csv"
});
for (i$ = 1, to$ = cpus.length; i$ <= to$; ++i$) {
  (fn$.call(this, i$));
}
cluster.on('exit', function(worker, code, signal){
  console.log('worker ' + worker.process.pid + ' died');
});
function fn$(i){
  cluster.fork();
}