# Removes

### Descripción
Estos comandos son para hacerle build a mongo db input de logstash 
```python
docker file

docker build -t prueba . 


run Mario

docker run --rm -it --net aibulb_OurNetwork --ip 10.0.0.22 -v "C:\Users\mario\OneDrive - Estudiantes ITCR\Documentos\GitHub\AIBulb\pipeline:/usr/share/logstash/pipeline/" -v "C:\Users\mario\OneDrive - Estudiantes ITCR\Documentos\GitHub\AIBulb\logstashconfig:/usr/share/logstash/config/" prueba

docker run -d --net aibulb_OurNetwork --ip 10.0.0.23 --name elastic -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -v "C:\Users\mario\OneDrive - Estudiantes ITCR\Documentos\GitHub\AIBulb\elasticconfig:/usr/share/elasticsearch/config" elasticsearch:8.7.1

docker run -d --name dashserver --net aibulb_OurNetwork -p 5601:5601 kibana:8.7.1

```