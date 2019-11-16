docker build -t ret83/fibo-client:latest -t ret83/fibo-client:$SHA -f ./client/Dockerfile ./client
docker build -t ret83/fibo-server:latest -t ret83/fibo-server:$SHA -f ./server/Dockerfile ./server
docker build -t ret83/fibo-worker:latest -t ret83/fibo-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ret83/fibo-client:latest
docker push ret83/fibo-server:latest
docker push ret83/fibo-worker:latest

docker push ret83/fibo-client:$SHA
docker push ret83/fibo-server:$SHA
docker push ret83/fibo-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ret83/fibo-server:$SHA
kubectl set image deployments/client-deployment client=ret83/fibo-client:$SHA
kubectl set image deployments/worker-deployment worker=ret83/fibo-worker:$SHA
