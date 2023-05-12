# Встановлюємо базовий образ
FROM ubuntu:latest

# Оновлюємо пакети та встановлюємо Python 3 та pip3
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Копіюємо наш додаток у директорію /app у контейнері
COPY . /app
WORKDIR /app

# Встановлюємо залежності Python
RUN pip3 install -r requirements.txt

# Виконуємо команду запуску додатку
CMD ["python3", "app.py"]

