var cluster, func;
cluster = require('cluster');
func = function(){
  console.log(cluster.worker.process.pid);
  setTimeout(function(){
    func();
  }, 1000);
};
func();