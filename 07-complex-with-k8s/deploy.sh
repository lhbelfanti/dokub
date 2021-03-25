docker build -t lhbelfanti/multi-client:latest -t lhbelfanti/multi-worker:$SHA -f ./07-complex-with-k8s/client/Dockerfile ./07-complex-with-k8s/client
docker build -t lhbelfanti/multi-server:latest -t lhbelfanti/multi-worker:$SHA -f ./07-complex-with-k8s/server/Dockerfile ./07-complex-with-k8s/server
docker build -t lhbelfanti/multi-worker:latest -t lhbelfanti/multi-worker:$SHA -f ./07-complex-with-k8s/worker/Dockerfile ./07-complex-with-k8s/worker

docker push lhbelfanti/multi-client:latest
docker push lhbelfanti/multi-server:latest
docker push lhbelfanti/multi-worker:latest

docker push lhbelfanti/multi-client:$SHA
docker push lhbelfanti/multi-server:$SHA
docker push lhbelfanti/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployments client=lhbelfanti/multi-client:$SHA
kubectl set image deployments/server-deployments server=lhbelfanti/multi-server:$SHA
kubectl set image deployments/worker-deployments worker=lhbelfanti/multi-worker:$SHA