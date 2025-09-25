Backend 1.0 (FastAPI)

Установка и запуск:

1) Установите зависимости:
   pip install -r requirements.txt

2) Запустите сервер:
   uvicorn main:app --reload --host 0.0.0.0 --port 5000

Сервер будет доступен на: http://localhost:5000

API:
- POST /submit - принимает JSON { "text": "..." } и сохраняет в data.txt
- GET / - приветственное сообщение

Ожидаемый фронтенд v1.0:
- Отправляет POST запросы на /submit с JSON данными