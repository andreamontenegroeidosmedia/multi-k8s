docker build -t andreamontenegroem/multi-client:latest -t andreamontenegroem/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andreamontenegroem/multi-server:latest -t andreamontenegroem/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andreamontenegroem/multi-worker:latest -t andreamontenegroem/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andreamontenegroem/multi-client:latest
docker push andreamontenegroem/multi-server:latest
docker push andreamontenegroem/multi-worker:latest

docker push andreamontenegroem/multi-client:$SHA
docker push andreamontenegroem/multi-server:$SHA
docker push andreamontenegroem/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=andreamontenegroem/multi-client:$SHA
kubectl set image deployments/server-deployment server=andreamontenegroem/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=andreamontenegroem/multi-worker:$SHA
