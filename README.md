# Aria2-compose  
(Very) lightweight aria2 server with webUI and optimization  
Based on [Photon-WebUI](https://github.com/zmzhang8/Photon-WebUI)

- `arm` image, you can run it on Raspberry PI!
- approximately `13mb` total footprint on your hard drive!

# Setup
Copy this compose file and paste it in your perfered directory  
```yaml
version: '3.1'
services:
  aria2:
    image: thewh1teagle/aria2
    volumes:
      - ./downloads:/app/downloads
    ports:
      - 6801:6800
  web:
    image: thewh1teagle/photon-webui
    ports:
      - 3000:3000

```
You can specify different downloads folder on your system, instead of `./downloads`  
In the same directory of `docker-compose.yaml` execute the following  
`docker compose up`

## Gotchas
For some reason on Raspberry PI I got permission denied when trying to write to `downloads` volume.  
The solution is to create the folder before running `docker compose up` and give it the right permission
```
mkdir dodwnloads
sudo chmod 777 downloads
docker compose up
```

## Screenshots


<img src="screenshot/downloading.png" width="80%" height="80%"></img>
