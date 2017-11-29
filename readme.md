Elecciones Chile 2017
================

En este sitio web encontrarás visualizaciones del contenido de las cuentas de twitter de los candidatos presidenciales en Chile 2017 **como redes sociales**. Tanto la descarga de los datos como la creacion de este sitio web fue realizada con el lenguaje de programación R junto con los paquetes [rgexf](https://github.com/gvegayon/rgexf) y [twitterreport](https://github.com/gvegayon/twitterreport), ambos de los cuales [soy el autor](http://ggvy.cl). Este sitio web ha sido desarrollado para ilustrar el uso de estos paquetes de R (ver código [aquí](https://github.com/gvegayon/elecciones2017)).

Por el momento sólo tengo dos tipos de "análisis" (pues solo son visualizaciones de datos sin explicación :)):

1.  Redes semánticas de los tweets de los candidatos (cómo se relacionan las palabras que incluyen en sus tweets). Estas redes incluyen los últimos 1.000 tweets de cada candidato.

2.  Listado de palabras asociadas con cada candidato. Descargando los últimos 50.000 tweets que mencionan a cualquiera de los candidatos, construí el listado de conceptos que, en términos relativos, aparecen con mayor frecuencia con cada uno de ellos.

Ambos "análisis" utilizan el [Índice de Jaccard](https://es.wikipedia.org/wiki/%C3%8Dndice_Jaccard).

Este es un proyecto hermano de <https://elecciones2017.github.io/>

De qué hablan los candidatos de \#EleccionesChile2017?
======================================================

A continuación un listado de links a visualizaciones de las redes semánticas (?) de cada candidato. Si dos palabras aparecen conectadas significa que aparecen juntas de manera frecuente.

<p>
Red de <a href="carolinagoic/index.html">carolinagoic</a>
</p>
<p>
Red de <a href="eduardo_artes/index.html">eduardo\_artes</a>
</p>
<p>
Red de <a href="joseantoniokast/index.html">joseantoniokast</a>
</p>
<p>
Red de <a href="BeaSanchezYTu/index.html">BeaSanchezYTu</a>
</p>
<p>
Red de <a href="sebastianpinera/index.html">sebastianpinera</a>
</p>
<p>
Red de <a href="guillier/index.html">guillier</a>
</p>
<p>
Red de <a href="marcoporchile/index.html">marcoporchile</a>
</p>
<p>
Red de <a href="senadornavarro/index.html">senadornavarro</a>
</p>
<br>

Los datos de los tweets de los candidatos fueron actualizadas por ultima vez en 2017-11-29 02:25:42. Los datos utilizados para crear las redes estan en el archivo [candidatos.zip](candidatos.zip).

Qué se habla sobre los candidatos?
==================================

A continuación, una tabla con los las palabras que aparecen con mayor frecuencia junto a menciones a los candidatos. La tabla fue creada en base a la descarga de 50.000 tweets bajo el criterio de que fueran emitidos en español, y mencionaran al menos a uno de los candidatos.

|     | carolinagoic  | eduardo\_artes | joseantoniokast   | BeaSanchezYTu   | sebastianpinera | guillier      | marcoporchile   | senadornavarro |
|-----|:--------------|:---------------|:------------------|:----------------|:----------------|:--------------|:----------------|:---------------|
| 1   | buen          | acercaremos    | foto              | ahoranoticiasan | guillier2018    | cae           | guillier        | lcruzcoke      |
| 2   | ahora         | ahí            | hoy               | incluyo         | izquierda       | alejandro     | convencido      | candidatura    |
| 3   | bienvenida    | -              | equipokast        | 6               | hijos           | camilavallejo | entusiasmo      | lograremos     |
| 4   | bien          | -              | chilenosimportamg | guiña           | candidato       | gobierno      | avanzará        | ciudadana      |
| 5   | aún           | -              | ca                | error           | centro          | fin           | llamé           | juntos         |
| 6   | c             | -              | hipocresía        | giorgiojackson  | damos           | afp           | hacerlo         | gracias        |
| 7   | apoye         | -              | cuanta            | gabrielboric    | bienvenida      | candidato     | alegría         | navarro        |
| 8   | acuerdo       | -              | acusaba           | ahora           | apoyar          | campaña       | apoyarlo        | endosar        |
| 9   | 2             | -              | erikaoliverad     | beasanchezytu   | invitamos       | compromiso    | chilens         | convocatoria   |
| 10  | campaña       | -              | hace              | frenteamplio    | guillier        | ahora         | ls              | prensa         |
| 11  | andresvelasco | -              | gran              | elfrenteamplio  | q               | día           | candidatura     | mil            |
| 12  | adnradiochile | -              | candidato         | faupar          | cultura         | elmostrador   | gracias         | 10             |
| 13  | 24horastvn    | -              | cariño            | karolcariola    | ciudadanos      | familias      | compromiso      | apoyar         |
| 14  | 3             | -              | chilenos          | jajajaja        | chilenos        | chilenas      | lograremos      | marcoporchile  |
| 15  | biobio        | -              | felipekast        | cc              | elmostrador     | gran          | ciudadana       | hace           |
| 16  | apoyo         | -              | cadem             | guillier        | miembros        | baradit       | juntos          | alejandro      |
| 17  | buena         | -              | ahora             | hombre          | día             | apoyo         | apoyar          | gran           |
| 18  | ahí           | -              | después           | d               | maduro          | bien          | gt              | guillier       |
| 19  | acuer         | -              | encuesta          | 17              | piñera          | aliviaremos   | losprogresistas | apoyo          |

Los tweets mencionando candidatos fueron actualizadas por ultima vez en 2017-11-29 02:24:37. Los datos utilizados para crear las tablas [sobre\_candidatos.zip](sobre_candidatos.zip).

Metodología
===========

En términos sencillos, dependiendo del tipo de "análisis", lo que hice para generar los datos fue lo siguiente:

1.  Descargar tweets usando la API de twitter a través del paquete twitterreport.

2.  De cada tweet, eliminar los stopwords y luego calcular el [Índice de Jaccard](https://es.wikipedia.org/wiki/%C3%8Dndice_Jaccard) utilizando todos los tweets disponibles del candidato

3.  En el caso de las redes, dicotomizar la matriz resultante del paso anterior dejando como 1 si la celda es mayor a la mediana, de lo contrario queda como 0.

4.  Filtrar los 100 términos más populares de la lista (según la diagonal de la matriz de similitud)

5.  Con esa matriz, una matriz adjacente ahora, identificar clusters (para eso utilicé igraph, en particular, el algoritmo Fast Greedy) y etiquetar (colorear) las palabras según comunidad

6.  Generar un layout y exportar utilizando el paquete rgexf.

Contacto
========

George G. Vega Yon

[@gvegayon](https://twitter.com/gvegayon)

<http://ggvy.cl>
