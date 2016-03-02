import os

from keystoneclient.v3 import client


HOST = os.environ.get('HOST', '192.168.111.222')
KEYSTONE_ENDPOINT = os.environ.get(
    'KEYSTONE_ENDPOINT', 'http://%s:35357/' % HOST)


c = client.Client(
    token='ADMIN',
    endpoint=KEYSTONE_ENDPOINT + 'v3')

domain = c.domains.get('default')

try:
    role = c.roles.create(name='admin')
except Exception:
    role = c.roles.list(name='admin')[0]

try:
    group = c.groups.create(domain=domain, name='admin')
except Exception:
    group = c.groups.list(domain=domain, name='admin')[0]

c.roles.grant(group=group, domain=domain, role=role)

try:
    project = c.projects.create(domain=domain, name='admin')
except Exception:
    project = c.projects.list(domain=domain, name='admin')[0]

c.roles.grant(group=group, project=project, role=role)

password = 'password'
try:
    user = c.users.create(
        domain=domain, name='admin', password=password)
except Exception:
    user = c.users.list(domain=domain, name='admin')[0]

c.users.add_to_group(user=user, group=group)

services = c.services.list(name='Keystone', type='identity')
if services:
    service = services[0]
else:
    service = c.services.create(
        name='Keystone', type='identity')

endpoints = c.endpoints.list(service=service)
public_endpoints = [e for e in endpoints if e.interface == 'public']
admin_endpoints = [e for e in endpoints if e.interface == 'admin']

if not public_endpoints:
    public_endpoint = c.endpoints.create(
        service=service,
        interface='public',
        url=KEYSTONE_ENDPOINT + 'v3')

if not admin_endpoints:
    admin_endpoint = c.endpoints.create(
        service=service,
        interface='admin',
        url=KEYSTONE_ENDPOINT + 'v3')

unscoped = client.Client(
    username='admin',
    password='password',
    auth_url=KEYSTONE_ENDPOINT + 'v3')
print('Unscoped token: %s' % unscoped.auth_token)

project_scoped = client.Client(
    username='admin',
    password='password',
    project_name='admin',
    auth_url=KEYSTONE_ENDPOINT + 'v3')
print('Project-scoped token: %s' % project_scoped.auth_token)

domain_scoped = client.Client(
    username='admin',
    password='password',
    domain_name='Default',
    auth_url=KEYSTONE_ENDPOINT + 'v3')
print('Domain-scoped token: %s' % domain_scoped.auth_token)
