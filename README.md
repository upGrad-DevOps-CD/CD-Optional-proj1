## Update baseUrl with public ip of ec2 instance 
```
let baseUrl;
const apiVersion = 'v1';
baseUrl = "http://<your_public_ip>:8080";
export const environment={
    baseUrl
}
```

## How to run 
docker-compose up --build -d
