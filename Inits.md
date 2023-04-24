# Inits 
*Aquí se inicializarán todo lo necesario para el funcionamiento del sharding*
## Camilo
*Aquí se inicializa el compose del host principal*
```python
docker-compose -f docker-compose-cam.yml up -d
```

### Initializing replica set for config servers
```python
rs.initiate(
  {
    _id: "configrs",
    configsvr: true,
    members: [
      { _id : 0, host : "25.3.189.113:27119" },
      { _id : 1, host : "25.3.189.113:27120" }
    ]
  }
);
```


### Initializing replica set from Camilo
```python
rs.initiate(
  {
    _id : "Camilo",
    members: [
      { _id : 0, host : "25.3.189.113:27130" },
      { _id : 1, host : "25.3.189.113:27131" },
      { _id : 2, host : "25.3.189.113:27132" } 
    ]
  }
);
```

#### Initializing routers... (router)
```python
sh.addShard( "Camilo/25.3.189.113:27130")
sh.addShard( "CompuMario/25.3.224.0:27124")
sh.addShard( "Raulis/25.19.99.53:27121")
sh.addShard( "Stephanie/25.3.188.46:27127")
```

#### addShardTag
*Se inicializan cuando se hacen los iniciate de todos shards independientes (router)*

```python
sh.addShardTag("Camilo", "Guatemala");
sh.addShardTag("CompuMario", "Costa Rica");
sh.addShardTag("Raulis", "Mexico");
sh.addShardTag("Stephanie", "Estado Unidos");

```
#### addTagRange
*Se inicializan cuando se hacen los initiate de todos shards independientes (router)*

```python
#Se hace seguido del addSharTag
sh.addTagRange( "disponibles.servicios",
                { pais: "Guatemala"},
                { pais: "Guatemala1"},
                "Guatemala"
              );

sh.addTagRange( "disponibles.servicios",
                { pais: "Costa Rica"},
                { pais: "Costa Rica1"},
                "Costa Rica"
              );

sh.addTagRange( "disponibles.servicios",
                { pais: "Mexico"},
                { pais: "Mexico1"},
                "Mexico"
              );

sh.addTagRange( "disponibles.servicios",
                { pais: "Estado Unidos"},
                { pais: "Estado Unidos1"},
                "Estado Unidos"
              );
# Se hace seguido del addTagRange              
sh.enableSharding("disponibles");
# Se hace seguido del enableSharding
sh.shardCollection("disponibles.servicios", { pais : 1 } );
# Se hace seguido del shardCollection
db.adminCommand({
  "setDefaultRWConcern" : 1,
  "defaultWriteConcern" : {
    "w" : 2
  },
  "defaultReadConcern" : { "level" : "available" }
});
```

#### arbitro de Camilo 
```python
rs.addArb("25.3.189.113:27136");

```

## Mario
```python
docker-compose -f docker-compose-mar.yml up -d
```
#### Inicializar replica set de Mario
```python
rs.initiate(
  {
    _id : "CompuMario",
    members: [
      { _id : 0, host : "25.3.224.0:27124" },
      { _id : 1, host : "25.3.224.0:27125" },
      { _id : 2, host : "25.3.224.0:27126" } 
    ]
  }
);

```
#### arbitro de Mario
```python
rs.addArb("25.3.224.0:27134");

```

## Raul
```python
docker-compose -f docker-compose-rau.yml up -d
```
#### Inicializar replica set de Raul
```python
rs.initiate(
  {
    _id : "Raulis",
    members: [
      { _id : 0, host : "25.19.99.53:27121" },
      { _id : 1, host : "25.19.99.53:27122" },
      { _id : 2, host : "25.19.99.53:27123" } 
    ]
  }
);
  
  ```

#### arbitro de Raul
```python
rs.addArb("25.19.99.53:27133");
  
  ```

## Stephanie
```python
docker-compose -f docker-compose-ste.yml up -d
```
#### Inicializar replica set de Stephanie
```python

rs.initiate(
  {
    _id : "Stephanie",
    members: [
      { _id : 0, host : "25.3.188.46:27127" },
      { _id : 1, host : "25.3.188.46:27128" },
      { _id : 2, host : "25.3.188.46:27129" } 
    ]
  }
);

```
#### arbitro de Stephanie
```python
rs.addArb("25.3.188.46:27135");

```