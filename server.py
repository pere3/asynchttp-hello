from aiohttp import web
import socket

async def handle(request):
    hostname = socket.gethostname()
    text = f'Hello from {hostname}'
    return web.Response(text=text)

app = web.Application()
app.router.add_get('/', handle)

web.run_app(app)
