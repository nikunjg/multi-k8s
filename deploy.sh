docker build -t nikunjgupta9/multi-client:latest -t nikunjgupta9/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nikunjgupta9/multi-server:latest -t nikunjgupta9/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nikunjgupta9/multi-worker:latest -t nikunjgupta9/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nikunjgupta9/multi-client:latest
docker push nikunjgupta9/multi-server:latest
docker push nikunjgupta9/multi-worker:latest


docker push nikunjgupta9/multi-client:$SHA
docker push nikunjgupta9/multi-server:$SHA
docker push nikunjgupta9/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nikunjgupta9/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nikunjgupta9/multi-worker:$SHA
kubectl set image deployments/server-deployment server=nikunjgupta9/multi-server:$SHA
