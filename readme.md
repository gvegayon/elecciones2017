
Qué hablan los candidatos de \#EleccionesChile2017?: Contenidos de twitter como redes sociales
==============================================================================================

En este sitio web encontrarás visualizaciones del contenido de las cuentas de twitter de los candidatos presidenciales en Chile 2017 **como redes sociales**. Tanto la descarga de los datos como la creacion de este sitio web fue realizada con el lenguaje de programación R junto con los paquetes [rgexf](https://github.com/gvegayon/rgexf) y [twitterreport](https://github.com/gvegayon/twitterreport), ambos de los cuales [soy el autor](http://ggvy.cl). Este sitio web ha sido desarrollado para ilustrar el uso de estos paquetes de R (ver código [aquí](https://github.com/gvegayon/elecciones2017)).

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

Metodología
===========

En términos sencillos, lo que presento aquí fue construido siguien

1.  Descargar ~2000 tweets por candidato (o lo que tengan!)

2.  De cada tweet, eliminar los stopwords y luego calcular el [Índice de Jaccard](https://es.wikipedia.org/wiki/%C3%8Dndice_Jaccard) utilizando todos los tweets disponibles del candidato

3.  Dicotomizar la matriz resultante del paso anterior dejando como 1 si la celda es mayor a la media, de lo contrario queda como 0.

4.  Filtrar los 100 términos más populares de la lista (según la diagonal de la matriz de similitud)

5.  Con esa matriz, una matriz adjacente ahora, identificar clusters (para eso utilicé igraph, en particular, el algoritmo Fast Greedy) y etiquetar (colorear) las palabras según comunidad

6.  Generar un layout y exportar utilizando el paquete rgexf.

Contacto
========

George G. Vega Yon

[@gvegayon](https://twitter.com/gvegayon)

<http://ggvy.cl>
