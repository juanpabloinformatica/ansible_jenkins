import uvicorn
from fastapi import FastAPI

app = FastAPI()

# adding some coments
@app.get("/")
async def root():
    return {"message": "Hello World"}

if __name__=="__main__":
    uvicorn.run("main:app",host="0.0.0.0",port=4567,reload=True)
