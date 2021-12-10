# Домашнее задание к занятию "14.3 Карты конфигураций"

## Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать карту конфигураций? Как просмотреть список карт конфигураций?

```
kubectl create configmap nginx-config --from-file=nginx.conf
kubectl create configmap domain --from-literal=name=netology.ru
```
```
kubectl get configmaps
kubectl get configmap
```
### Ответ.
 
![Screenshot](1.png)

### Как просмотреть карту конфигурации?

```
kubectl get configmap nginx-config
kubectl describe configmap domain
```
### Ответ.

![Screenshot](2.png)

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json
```
### Ответ.

![Screenshot](3.png)

### Как выгрузить карту конфигурации и сохранить его в файл?

```
kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml
```

### Ответ.

![Screenshot](4.png)
![Screenshot](5.png)

### Как удалить карту конфигурации?

```
kubectl delete configmap nginx-config
```

### Ответ.

![Screenshot](6.png)


### Как загрузить карту конфигурации из файла?

```
kubectl apply -f nginx-config.yml
```
### Ответ.

![Screenshot](7.png)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

https://github.com/AlexanderSpitsyn07/kubercloud/tree/master/DZconfmap

---


