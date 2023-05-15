# Déployer l'api et le cache en local

## Sommaire

1. Construire les images
2. Déployer avec Docker
3. Supprimer les objets Docker
4. Déployer avec Docker Compose
5. Supprimer les objets Docker Compose
6. Déployer avec Kubernetes
7. Supprimer les objets Kubernetes

## 1. Construire les images

### Manuellement

Placer vous à la racine du projet et exécuter les commandes suivantes

#### Construire l'image de l'api

```sh
docker build \
  --tag episen-sca/app \
  --file app/Dockerfile \
  --build-arg REDIS_URL=redis://episen-sca_cache:6379 \
  app
```

#### Construire l'image du cache (redis)

```sh
docker build \
  --tag episen-sca/cache \
  --file cache/Dockerfile \
  cache
```

### Avec un script

Placer vous à la racine du projet et exécuter la commande suivante

#### Construire les images de l'api et du cache

```sh
./scripts/docker_build.sh
```

## Déployer avec Docker

Placer vous à la racine du projet et exécuter la commande suivante

### Démarrer des conteneurs pour l'api et le cache (mode développement)

```sh
./scripts/docker_dev.sh
```
### Démarrer des conteneurs pour l'api et le cache (mode production)

```sh
./scripts/docker_start.sh
```

### Lancer les tests de l'api dans un conteneur

```sh
./scripts/docker_test.sh
```

## Supprimer les objets Docker

Placer vous à la racine du projet et exécuter la commande suivante

### Suppression des conteneurs, des réseaux, des images et des volumes (api et cache)

```sh
./scripts/docker_clean.sh
```

## Déployer avec Docker Compose

Placer vous à la racine du projet et exécuter la commande suivante

### Démarrer des conteneurs pour l'api et le cache (mode développement)

```sh
./scripts/compose_dev.sh
```

### Démarrer des conteneurs pour l'api et le cache (mode production)

```sh
./scripts/compose_start.sh
```

### Lancer les tests de l'api dans un conteneur

```sh
./scripts/compose_test.sh
```

## Supprimer les objets Docker Compose

Placer vous à la racine du projet et exécuter la commande suivante

### Suppression des conteneurs, des réseaux, des images et des volumes (api et cache)

```sh
./scripts/compose_clean.sh
```

## Déployer avec Kubernetes

* Installer un cluster Kubernetes local avec [Docker Desktop](https://docs.docker.com/desktop/kubernetes/)
* Installer NGINX Ingress Controller ([pour `kubernetes`](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start))

### On déploie le Deployment et le Service
Placer vous à la racine du projet et exécuter la commande suivante :

```sh
kubectl apply -f deployment.yaml
```

⚠️ N'oubliez pas construire les images de l'api et du cache avant d'éxecuter la commande.

### On déploie l'Ingress

Placer vous à la racine du projet et exécuter la commande suivante :

```sh
kubectl apply -f ingress.yaml
```

⚠️ N'oubliez pas de modifier `/etc/hosts` pour que le host spécifié dans l'ingress soit trouvé par votre navigateur. Voici un exemple :

```sh
127.0.0.1 app.localhost
```

## Supprimer les objets Kubernetes

Placer vous à la racine du projet et exécuter la commande suivante :

```sh
./scripts/kube_clean.sh
```