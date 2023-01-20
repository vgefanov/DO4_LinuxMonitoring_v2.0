#!/bin/bash

function get_time {
  local hour=$(($RANDOM % 23))
  local minute=$(($RANDOM % 59))
  local second=$(($RANDOM % 59))
  if [[ $hour -lt 10 ]]; then
    local hour="0"$hour
  fi
  if [[ $minute -lt 10 ]]; then
    local minute="0"$minute
  fi
  if [[ $second -lt 10 ]]; then
    local second="0"$second
  fi
  local date=$hour":"$minute":"$second
  echo $date
}

function get_ip {
  local ip=$((1 + $RANDOM % 255))
  for i in {1..3}
  do
    local ip+="."$(($RANDOM % 255))
  done
  echo $ip
}

function get_method {
  local methods=(GET POST PUT PATCH DELETE)
  local number=$(($RANDOM % 5))
  echo ${methods[$number]}
}

function get_extension {
  local ext=(.gif .jpg .png .php .css .ico)
  local number=$(($RANDOM % 6))
  echo ${ext[$number]}
}

function get_url {
  local number=$((2 + $RANDOM % 4))
  local URL="/"$(head -c 50 /dev/random | base64 | tr -d [:upper:][:punct:] | tail -c $number)
  for((i=0; i<$number; i++))
  do
    local URL+="/"$(head -c 100 /dev/urandom | base64 | tr -d [:upper:][:punct:] | tail -c $number)
  done
  URL+="$(get_extension)"
  echo $URL
}

function get_code {
  local codes=(200 201 400 401 403 404 500 501 502 503)
  local number=$(($RANDOM % 10))
  echo ${codes[$number]}
}

#Коды ответа
  #Успешные 200 - 299
    #200 OK Запрос успешно обработан. Что значит "успешно", зависит от метода HTTP, который был запрошен:
      #GET Метод запрашивает представление ресурса. Запросы с использованием этого метода могут только извлекать данные;
      #POST используется для отправки сущностей к определённому ресурсу. Часто вызывает изменение состояния или какие-то побочные эффекты на сервере;
      #PUT заменяет все текущие представления ресурса данными запроса;
      #PATCH используется для частичного изменения ресурса;
      #DELETE удаляет указанный ресурс;
    #201 Created Запрос успешно выполнен и в результате был создан ресурс. Этот код обычно присылается в ответ на запрос PUT
  #Клиентские ошибки 400 - 499
    #400 Bad Request Этот ответ означает, что сервер не понимает запрос из-за неверного синтаксиса;
    #401 Unauthorized Для получения запрашиваемого ответа нужна аутентификация. Статус похож на статус 403, но,в этом случае, аутентификация возможна;
    #403 Forbidden У клиента нет прав доступа к содержимому, поэтому сервер отказывается дать надлежащий ответ;
    #404 Not Found Сервер не может найти запрашиваемый ресурс. Код этого ответа, наверно, самый известный из-за частоты его появления в вебе;
  #Серверные ошибки 500 - 599
    #500 Internal Server Error Сервер столкнулся с ситуацией, которую он не знает как обработать;
    #501 Not Implemented Метод запроса не поддерживается сервером и не может быть обработан. Единственные методы, которые сервера должны поддерживать (и, соответственно, не должны возвращать этот код) - GET и HEAD;
    #502 Bad Gateway Эта ошибка означает что сервер, во время работы в качестве шлюза для получения ответа, нужного для обработки запроса, получил недействительный (недопустимый) ответ;
    #503 Service Unavailable Сервер не готов обрабатывать запрос. Зачастую причинами являются отключение сервера или то, что он перегружен.

function get_agent {
  local agent=(Mozilla 'Google Chrome' Opera Safari 'Internet Explorer' 'Microsoft Edge' 'Crawler and bot' 'Library and net tool')
  local number=$(($RANDOM % 8))
  echo ${agent[$number]}
}
