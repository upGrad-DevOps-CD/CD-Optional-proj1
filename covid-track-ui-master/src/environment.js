
let baseUrl;
const apiVersion = 'v1';

const hostname = window && window.location && window.location.hostname;

const cloudHosts = ['ec2-52-73-149-55.compute-1.amazonaws.com',"52.73.149.55"]
if(cloudHosts.includes(hostname)) {
    baseUrl = 'http://ec2-52-73-149-55.compute-1.amazonaws.com:8080';

} else {
    baseUrl = "http://localhost:8080";
}




export const environment={
    baseUrl
}
