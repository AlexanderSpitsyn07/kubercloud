# Домашнее задание к занятию "14.4 Сервис-аккаунты"

## Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать сервис-аккаунт? Как просмотреть список сервис-акаунтов?

```
kubectl create serviceaccount netology
kubectl get serviceaccounts
kubectl get serviceaccount
```
### Ответ.

![Screenshot](1-1.png)

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get serviceaccount netology -o yaml
kubectl get serviceaccount default -o json
```
### Ответ.

![Screenshot](1-2.png)

### Как выгрузить сервис-акаунты и сохранить его в файл?

```
kubectl get serviceaccounts -o json > serviceaccounts.json
kubectl get serviceaccount netology -o yaml > netology.yml
```
### Ответ.

![Screenshot](1-3.png)

### Как удалить сервис-акаунт? Как загрузить сервис-акаунт из файла?

```
kubectl delete serviceaccount netology
kubectl apply -f netology.yml
```
### Ответ.

![Screenshot](1-4.png)

## Задача 2 (*): Работа с сервис-акаунтами внутри модуля

Выбрать любимый образ контейнера, подключить сервис-акаунты и проверить
доступность API Kubernetes. Просмотреть переменные среды.

```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
env | grep KUBE

```
![Screenshot](2-1.png)

Получить значения переменных

```
K8S=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
SADIR=/var/run/secrets/kubernetes.io/serviceaccount
TOKEN=$(cat $SADIR/token)
CACERT=$SADIR/ca.crt
NAMESPACE=$(cat $SADIR/namespace)
```
![Screenshot](2-2.png)

Подключаемся к API

```
curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/api/v1/
```
![Screenshot](2-3.png)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---


---





