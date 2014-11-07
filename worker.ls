require! <[ cluster ]>

func = !->
  console.log(cluster.worker.process.pid)
  setTimeout do
    !-> func!
    1000
func!


