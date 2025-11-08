# TravelSources.com

E-commerce Store where travelers find all what they need for traveling wi ease!

## infra Stack : 

eks - kafka - postgres - debezium Cdc 

frontend + backend ( microservices auth, catalog, cart, orders , payements, notifications)

## ci : github actions 

build test scan tag push + update gitops repo (multi branch dev stg and prod)

## cd : argocd + argoRollout 

each microservices has its own applicationSet bined to each env 

## IAc tool : 

terragrunt and terraform (multi env (dev, stg, prod))

## ingress and tls: 

istio + cert manager let's encrypt + mtls + route53 (travelsources.com) (frontend travelsources.com and backend api.travelsources.com) + external Dns

## monitoring and logging : 

prometheus stack  + loki 

## autoscaling  : 

hpa + karpenter+irsa 

## secrets : 

External secrets operator + irsa 

## storage and backup 

ebs csi + pvcs for statefullset (kafka + postgres)

## networking :

vpc + public +private subnets + nat + gateways and vpc endpoints

## Disaster recovery : 

another env : Dr in another region pilotLight Config + ebs snapshot and copy to other region

## EventResponse  

lambdas and eventBridge 

## users and groups 

aws organization  + sso + rbacs 
