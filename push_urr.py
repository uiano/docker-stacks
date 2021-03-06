#!/usr/bin/env python3
import docker

client = docker.from_env()
client.login(username='bendid13', password=r'', registry='urr.uia.no')
cli = docker.APIClient(base_url='unix://var/run/docker.sock')
for image in client.images.list():
    try:
        if "urr.uia.no/jupyter" in image.tags[0]:

            print (image.tags[0])
            for line in cli.push(image.tags[0], stream=False, decode=True):
                print(line)
            print ("\n")
        else:
            ...
    except IndexError:
        ...
