from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Data(BaseModel):
    text: str

@app.get("/")
async def root():
    return {"message": "Welcome to the FastAPI Backend"}

@app.get("/favicon.ico")
async def favicon():
    return {"message": "No favicon available"}

@app.post("/submit")
async def save_data(item: Data):
    with open("data.txt", "a") as f:
        f.write(item.text + "\n")
    return {"message": "Data saved"}
