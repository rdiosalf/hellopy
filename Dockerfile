# Usa una imagen base oficial de Python
FROM python:3.11-slim

ARG DNS_SERVER=8.8.8.8
RUN echo "nameserver ${DNS_SERVER}" > /etc/resolv.conf

# Evita prompts interactivos durante instalaciones
#ENV DEBIAN_FRONTEND=noninteractive

# Establece el directorio de trabajo
WORKDIR /app



# Instala certificados necesarios y actualiza pip y setuptools
#RUN apt-get update && \
 #   apt-get install -y --no-install-recommends ca-certificates && \
  #  apt-get clean && rm -rf /var/lib/apt/lists/* && \
   # pip install --upgrade pip setuptools    

# Verifica rutas y versiones de Python y pip
RUN which python && python --version && \
    which pip && pip --version

# Actualiza pip y setuptools a versiones recientes
#RUN pip install --upgrade pip setuptools

### con esto sabré si tengo salida a internet desde el contenedor que estoy montando
### si devuelve 200 301 hay acceso a internet desde el contenedor
##RUN apt-get update && apt-get install -y curl && curl -I https://pypi.org---- devuelve 8 295.2 W: Failed to fetch http://deb.debian.org/debian/dists/bookworm/InRelease  Temporary failure resolving 'deb.debian.org' luego no hay acceso a internet



# Copia los archivos necesarios al contenedor
COPY requirements.txt .
RUN pip install --no-cache-dir  -r requirements.txt
COPY app.py .


## muestra version de flask instalada
RUN pip show flask

# Expone el puerto 8080
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]