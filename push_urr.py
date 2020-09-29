#!/usr/bin/env python3
import docker

client = docker.from_env()
client.login(username='bendid13', password=r'', registry='urr.uia.no')
cli = docker.APIClient(base_url='unix://var/run/docker.sock')
for image in client.images.list():
    try:
        if "urr.uia.no/jupyter" in image.tags[0]:
            #for line in cli.push(image.tags[0], stream=True, decode=True):
            #    print(line)

            print (image.tags[0])
            for line in cli.push(image.tags[0], stream=True, decode=True):
                print(line)
            print ("\n")
            #break
            #cli.push(image.tags[0], stream=True)

        else:
            ...
    except IndexError:
        ...


#>>> from docker import Client
#>>> cli = Client(base_url='tcp://127.0.0.1:2375')
#>>> response = [line for line in cli.push('yourname/app', stream=True)]
#>>> response