Сборка и запуск докер контейнера для тг-бота
```bash
docker build -t botapp ./
docker run -p 9001:9001 --name mybot-container botapp
```

Сборка и запуск qt-приложения 
```bash
cmake -Bbuild -S.
cmake --build build
./build/apptest
```

