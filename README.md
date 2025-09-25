Backend 1.0 (Flask)

Установка и запуск:

1) Установите зависимости:
   pip install -r requirements.txt

2) Запустите сервер:
   python app.py

Сервер будет доступен на: http://localhost:5000

API:
- POST /submit - принимает JSON { "text": "..." } и сохраняет в data.txt

Ожидаемый фронтенд v1.0:
- Отправляет POST запросы на /submit с JSON данными
