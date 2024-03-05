unit Archivo;

interface

uses
 Classes, SysUtils;

const
  ruta = 'C:/archivos_chatterbot/respuestas.dat';

  botName = 'Thomas';
  q_agentes = 22;
  q_maps = 10;
  longAgenteName = 12;
  longClase = 7;
  longDispo = 7;
  longQname1 = 8;
  longQcost1 = 8;
  longqfunc1 = 8;
  longQname2 = 8;
  longQcost2 = 8;
  longqfunc2 = 8;
  longQname3 = 8;
  longQcost3 = 8;
  longqfunc3 = 8;
  longQname4 = 8;
  longQcost4 = 8;
  longqfunc4 = 8;
  longMapaName = 10;
  longMapaLoc = 9;
  longMapaLanc = 10;
  longMapaDesc = 10;


  long = 7;

  desc_agente = 'El agente {agenteName} es de la clase {clase}. Su disponibilidad es de tipo {dispo}. Y sus habilidades son:';
  desc_habilQ = 'La Q se llama {qname1} y tiene un coste de {qcost1} y su funcion es {qfunc1}.';
  desc_habilE = 'La E se llama {qname2} y tiene un coste de {qcost2} y su funcion es {qfunc2}.';
  desc_habilC = 'La C se llama {qname3} y tiene un coste de {qcost3} y su funcion es {qfunc3}.';
  desc_habilX = 'La X se llama {qname4} y tiene un coste de {qcost4} y su funcion es {qfunc4}.';

  desc_mapa = 'El mapa {mapaName} esta localizado en {mapaLoc}. Fue lanzado {mapaLanc}. {mapaDesc}';

type
  habilidades_record = RECORD
    idAgente:integer;
    agente:string;
    habilidad1_name:string;
    habilidad1_description:string;
    habilidad1_price:string;

    habilidad2_name:string;
    habilidad2_description:string;
    habilidad2_price:string;

    habilidad3_name:string;
    habilidad3_description:string;
    habilidad3_price:string;

    habilidad4_name:string;
    habilidad4_description:string;
    habilidad4_price:string;
  end;

  clases_agentes_record = RECORD
    name:string;
    description:string;
  end;

  agentes_record = RECORD
    id:word;
    name:string[30];
    description:string;
    clase: string;
    disponibilidad: string;
    habilidadesID: integer;
  end;

  mapas_record = RECORD
  name:string;
  localizacion: string;
  fecha_lanzamiento: string;
  description:string;
  end;

  TRespuesta = record
    key: String[10]; // 'QUE', 'COMO', 'PORQUE', 'PARAQUE', 'CUANDO', 'OTROS'...
    pregunta: string[255];
    respuesta: String[255];
  end;

  TArchivo = File of TRespuesta;

  procedure EscribirRespuestasEnArchivo(var archivoRespuestas:TArchivo);
  function LeerRespuestas(var archivoRespuestas:TArchivo; pos:Integer):TRespuesta;
  function TamArchivo(var archivoRespuestas:TArchivo):Integer;

var
{ Init variables }
agentes:array [1..q_agentes] of agentes_record;

habilidades:array [1..q_agentes] of habilidades_record;

mapas:array [1..q_maps] of mapas_record;

clases:array [1..4] of clases_agentes_record;

implementation

procedure EscribirRespuestasEnArchivo(var archivoRespuestas:TArchivo);
const
  queesValorant = 'Valorant es un juego de disparos en primera persona tactico en el que dos equipos de cinco jugadores se enfrentan entre si en una serie de rondas.';

  comojugarValorant = 'Antes de cada ronda, los jugadores tienen la oportunidad de comprar armas, otros elementos. El equipo atacante debe plantar la bomba, mientras que el equipo defensor debe desactivarla.';
var
  respuesta: TRespuesta;
begin
  Assign(archivoRespuestas, ruta);
  Rewrite(archivoRespuestas);

  // Escribir las respuestas en el archivo
  respuesta.key := 'OTROS';
  respuesta.pregunta := 'HOLA,BUENAS,BUENAS TARDES,BUENOS DIAS,BUENAS NOCHES,OLA';
  respuesta.respuesta := 'Hola! En que puedo ayudarte?';
  Seek(archivoRespuestas, 0);
  Write(archivoRespuestas, respuesta);

  respuesta.key := 'COMO';
  respuesta.pregunta := 'ESTAS,VA,TE ENCUENTRAS,ANDAS,ANDA';
  respuesta.respuesta := 'Estoy bien, gracias por preguntar!';
  Seek(archivoRespuestas, 1);
  Write(archivoRespuestas, respuesta);

  respuesta.key := 'OTROS';
  respuesta.pregunta := 'ADIOS,CHAU,HASTA LUEGO,NOS VEMOS';
  respuesta.respuesta := 'Hasta luego! Que tengas un buen dia.';
  Seek(archivoRespuestas, 2);
  Write(archivoRespuestas, respuesta);

  respuesta.key := 'QUE';
  respuesta.pregunta := 'VALORANT';
  respuesta.respuesta := queesValorant;
  Seek(archivoRespuestas, 3);
  Write(archivoRespuestas, respuesta);

  respuesta.key := 'COMO';
  respuesta.pregunta := 'JUGAR,JUEGA,VALORANT';
  respuesta.respuesta := comojugarValorant;
  Seek(archivoRespuestas, 4);
  Write(archivoRespuestas, respuesta);

  respuesta.key := 'CUANTOS';
  respuesta.pregunta := 'MAPAS,MAPA';
  respuesta.respuesta := 'Hay ' + IntToStr(q_maps) + ' mapas en Valorant.';
  Seek(archivoRespuestas, 5);
  Write(archivoRespuestas, respuesta);

  respuesta.key := 'CUANTOS';
  respuesta.pregunta := 'PERONAJES,PERSONAJE,AGENTES,AGENTE';
  respuesta.respuesta := 'Hay ' + IntToStr(q_agentes) + ' agentes en Valorant.';
  Seek(archivoRespuestas, 6);
  Write(archivoRespuestas, respuesta);

  respuesta.key := 'OTROS';
  respuesta.pregunta := 'PERFECTO,GRACIAS,MUCHAS GRACIAS,MUCHISIMAS GRACIAS,GENIAL';
  respuesta.respuesta := 'Me alegra haberte podido ayudar!';
  Seek(archivoRespuestas, 7);
  Write(archivoRespuestas, respuesta);

  respuesta.key := 'QUIEN';
  respuesta.pregunta := 'SOS,ERES';
  respuesta.respuesta := 'Me presento, soy '+ +' estoy aqui para resolver cualquier duda que tengas sobre valorant!';
  Seek(archivoRespuestas, 7);
  Write(archivoRespuestas, respuesta);

  // Cerrar el archivo
  Close(archivoRespuestas);
end;

function LeerRespuestas(var archivoRespuestas:TArchivo; pos:Integer):TRespuesta;
begin
  Assign(archivoRespuestas, ruta);
  Reset(archivoRespuestas);

    Seek(archivoRespuestas, pos);
    Read(archivoRespuestas,  LeerRespuestas);
  // Cerrar el archivo
  Close(archivoRespuestas);
end;

function TamArchivo(var archivoRespuestas:TArchivo):Integer;
begin
    Assign(archivoRespuestas, ruta);
    //Para chequear si el archivo está creado y no de error al utilizar reset
    {$I-} //orden al compilador que deshabilite el control de IO
         Reset(archivoRespuestas);
    {$I+}
    TamArchivo:= Filesize(archivoRespuestas);
  Close(archivoRespuestas);
end;

procedure initArrays;
begin
{ Inicializar agentes }

{ for i:= 1 to q_agentes
if agentes[i].name == buscado then
  habilidades[agentes[i].id].habilidad2 }

{ Astra }
  {
agentes[0].id := 0;
agentes[0].name := 'Astra';
agentes[0].description :='Astra controla las energías del cosmos para dar forma al campo de batalla a su antojo. Con pleno dominio de su forma astral y un gran talento para la anticipación estratégica, siempre va eones por delante de los movimientos de sus enemigos.';
agentes[0].clase := 'Controlador';
agentes[0].disponibilidad := 'bloqueada de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[0].habilidades := 0;
habilidades[0].idAgente:= 0;
habilidades[0].agente :='Astra';
habilidades[0].habilidad1_name:= 'Pulso nova';
habilidades[0].habilidad1_description := 'coloca estrellas en Forma astral (X). Activa una estrella para detonar un Pulso nova. El Pulso nova se carga brevemente y explota, lo que aturde a todos los jugadores en la zona.';
habilidades[0].habilidad1_price := '12 segundos de reutilización.';
habilidades[0].habilidad2_name := 'Nebulosa';
habilidades[0].habilidad2_description := 'coloca estrellas en Forma astral (X). Activa una estrella para transformarla en una Nebulosa (humo). Usa (F) en una estrella para disiparla, lo que recupera la estrella para poder volver a colocarla tras un tiempo. Disipar una estrella crea una breve Nebulosa falsa en su ubicación antes de recuperarla.';
habilidades[0].habilidad2_price := '15 segundos de reutilización';
habilidades[0].habilidad3_name := 'Pozo gravitatorio';
habilidades[0].habilidad3_description := 'coloca estrellas en Forma astral (X). Activa una estrella para crear un Pozo gravitatorio. Atrae hacia el centro a todos los jugadores en la zona antes de que explote, lo que causa que todos los jugadores atrapados en el interior se vuelvan frágiles.';
habilidades[0].habilidad3_price := '12 segundos de reutilización.';
habilidades[0].habilidad4_name := 'Forma astral / Separación cósmica';
habilidades[0].habilidad4_description := 'activa (X) para entrar en Forma astral y poder colocar estrellas. Las estrellas se pueden reactivar más tarde para transformarlas en un Pulso nova, una Nebulosa o un Pozo gravitatorio. Cuando Separación cósmica está cargada, dispara en Forma astral para empezar a apuntar y, a continuación, usa el disparo para elegir dos ubicaciones. Se creará una Separación cósmica infinita que conecte los dos puntos. Separación cósmica bloquea las balas y atenúa en gran medida los sonidos.';
habilidades[0].habilidad4_price :='150 créditos (forma astral) / 7 puntos de definitiva.';


{ Breach }
{
agentes[1].id = 1;
agentes[1].name = 'Breach';
agentes[1].description = 'Breach es un iniciador sueco que utiliza sus habilidades para abrir brechas en el campo de batalla y crear oportunidades para su equipo. Sus habilidades le permiten aturdir a los enemigos, cegarlos y causarles daño, lo que lo convierte en un agente muy versátil.';
agentes[1].clase = 'Iniciador';
agentes[1].disponibilidad = 'bloqueada de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[1].habilidades = 1;
habilidades[1].idAgente = 1;
habilidades[1].agente = 'Breach';
habilidades[1].habilidad1_name = 'Explosión cegadora';
habilidades[1].habilidad1_description = 'Equipa una carga explosiva cegadora. Dispara para liberar una rápida explosión que atraviesa paredes. La carga ciega a todos los jugadores que la estén mirando.';
habilidades[1].habilidad1_price = '250 créditos';
habilidades[1].habilidad2_name = 'Falla';
habilidades[1].habilidad2_description = 'Equipa una bomba sísmica. Dispara para liberar un seísmo que aturde a todos los enemigos dentro de la zona de efecto.';
habilidades[1].habilidad2_price = 'gratuita';
habilidades[1].habilidad3_name = 'Réplica';
habilidades[1].habilidad3_description = 'Equipa una carga explosiva de fusión. Dispara para que se extienda por el terreno y explote, infligiendo gran daño a cualquiera que esté dentro de su zona de efecto.';
habilidades[1].habilidad3_price = '200 créditos';
habilidades[1].habilidad4_name = 'Fragor imparable';
habilidades[1].habilidad4_description = 'Equipa una carga explosiva sísmica. Dispara para crear un seísmo que se extiende por una gran zona en forma de cono. Este seísmo aturde y lanza por los aires a los enemigos.';
habilidades[1].habilidad4_price = '7 puntos de definitiva';

{ Brimstone }
agentes[2].id = 2;
agentes[2].name = 'Brimstone';
agentes[2].description = 'Brimstone es un comandante militar estadounidense que utiliza su arsenal orbital para dar apoyo a su equipo. Sus habilidades le permiten crear zonas de control, bloquear la visión y proporcionar a su equipo un impulso de ataque.';
agentes[2].clase = 'Controlador';
agentes[2].disponibilidad = 'desbloqueado desde el inicio';
agentes[2].habilidades = 2;
habilidades[2].idAgente = 2;
habilidades[2].agente = 'Brimstone';
habilidades[2].habilidad1_name = 'Incendiario';
habilidades[2].habilidad1_description = 'Equipa un lanzagranadas incendiarias. Dispara una granada que explota en cuanto toca el suelo, creando una zona de fuego persistente que daña a los jugadores que estén en su interior.';
habilidades[2].habilidad1_price = '250 créditos';
habilidades[2].habilidad2_name = 'Cortina de humo';
habilidades[2].habilidad2_description = 'Equipa un mapa táctico de la zona. Marca una ubicación del mapa y luego confirma el disparo para que caiga en dicho lugar una nube de humo de larga duración que bloquea la visión de los jugadores que estén en su interior. También es útil para impedir que los jugadores te vean si la colocas estratégicamente en huecos de puertas o pasillos estrechos.';
habilidades[2].habilidad2_price = '100 créditos';
habilidades[2].habilidad3_name = 'Baliza estimulante';
habilidades[2].habilidad3_description = 'Equipa una baliza estimulante que puedes lanzar hacia el frente. Al tocar el suelo la baliza se despliega creando un área o campo que otorga disparo rápido a todos los jugadores que estén en su interior.';
habilidades[2].habilidad3_price = '100 créditos';
habilidades[2].habilidad4_name = 'Golpe orbital';
habilidades[2].habilidad4_description = 'Equipa un mapa táctico de la zona y gracias a este puedes señalar una ubicación para disparar un potente golpe orbital de láser. Provoca un gran daño prolongado a los enemigos que se encuentren en la zona afectada.';
habilidades[2].habilidad4_price = '6 puntos de definitiva';

{ Chamber }
agentes[3].id = 3;
agentes[3].name = 'Chamber';
agentes[3].description = 'Chamber es un diseñador de armas siempre bien vestido y bien pertrechado que expulsa a los agresores con precisión letal. Aprovecha su arsenal personalizado para repeler, eliminar enemigos a distancia y crear la contingencia perfecta para cada plan.';
agentes[3].clase = 'Centinela';
agentes[3].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[3].habilidades = 3;
habilidades[3].idAgente = 3;
habilidades[3].agente = 'Chamber';
habilidades[3].habilidad1_name = 'Cazador de cabezas';
habilidades[3].habilidad1_description = 'actívala para equipar una pistola pesada. Utiliza el botón de modo de disparo alternativo para apuntar con la mira.';
habilidades[3].habilidad1_price = '100 créditos';
habilidades[3].habilidad2_name = 'Rendez-Vous';
habilidades[3].habilidad2_description = 'coloca dos anclajes de teleportación. Mientras estén en el suelo y al alcance, reactiva la habilidad para teleportarte rápidamente al otro anclaje. Los anclajes se pueden recoger para volver a colocarlos.';
habilidades[3].habilidad2_price = 'gratuita, 15 segundos de reutilización';
habilidades[3].habilidad3_name = 'Marca registrada';
habilidades[3].habilidad3_description = 'coloca una trampa que rastrea a enemigos. Cuando un enemigo visible entra en el alcance, la trampa inicia una cuenta atrás y, a continuación, desestabiliza el terreno a su alrededor, lo que crea un campo persistente que ralentiza a los jugadores que se encuentren en su interior.';
habilidades[3].habilidad3_price = '150 créditos';
habilidades[3].habilidad4_name = 'Tour de force';
habilidades[3].habilidad4_description = 'actívala para sacar un poderoso rifle de francotirador personalizado que mata a los enemigos con cualquier impacto directo. Matar a un enemigo genera un campo persistente que ralentiza a los jugadores que se encuentren en su interior.';
habilidades[3].habilidad4_price = '7 puntos de definitiva';

{ Cypher }
agentes[4].id = 4;
agentes[4].name = 'Cypher';
agentes[4].description = 'Cypher, como buen centinela, es capaz de adelantarse a los movimientos de los enemigos y cubrir posiciones. Sus habilidades están destinadas a la defensa, así que te recomendamos que lo uses si lo tuyo no es estar al pie del cañón y en el frente de línea. Más bien hay que usarlo creando estrategias con nuestros compañeros y acompañarlos en la batalla dándoles apoyo. Es un personaje que puede funcionar genial cuando se juega en el bando de los defensores y hay que mantener a salvo una zona de la SPIKE';
agentes[4].clase = 'Centinela';
agentes[4].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[4].habilidades = 4;
habilidades[4].idAgente = 4;
habilidades[4].agente = 'Cypher';
habilidades[4].habilidad1_name = 'Prisión cibernética';
habilidades[4].habilidad1_description = 'lanzas de inmediato una prisión cibernética. Esta prisión puede activarse a distancia, apuntando sobre ella, y al hacerlo se creará una zona que bloquea la visión de los enemigos si quieren atravesarla';
habilidades[4].habilidad1_price = '100 créditos';
habilidades[4].habilidad2_name = 'Cámara espía';
habilidades[4].habilidad2_description = 'te equipas con una cámara espía que puedes disparar para fijar en una ubicación. Una vez hecho eso puedes controlar la visión de la cámara (dejando expuesto a Cypher, así que cuidado) para ver lo mismo que ella ve, e incluso puedes disparar un dardo marcador que revelará la posición del enemigo al que alcance.';
habilidades[4].habilidad2_price = 'gratuita';
habilidades[4].habilidad3_name = 'Cable trampa';
habilidades[4].habilidad3_description = 'te equipas con un cable trampa, destructible pero oculto. Puedes dispararlo hacia una pared y este se extenderá hacia la pared del lado opuesto, y también puedes recogerlo para moverlo hacia otra posición. Los jugadores enemigos que atraviesen el cable se quedarán anclados y su posición se revelará, si no logran dispararle a tiempo para librarse acabarán finalmente aturdidos.';
habilidades[4].habilidad3_price = '200 créditos';
habilidades[4].habilidad4_name = 'Hurto neuronal';
habilidades[4].habilidad4_description = 'puedes apuntar sobre un enemigo muerto con tu mira y usar esta habilidad al instante para revelar la posición de todos los enemigos vivos restantes. Especialmente útil cuando solo quedan unos pocos oponentes o no sabes dónde se esconden.';
habilidades[4].habilidad4_price = '7 puntos de definitiva';

{ Fade }
agentes[5].id = 5;
agentes[5].name = 'Fade';
agentes[5].description = 'Fade, la cazarrecompensas turca, desata el poder de las pesadillas para apoderarse de los secretos del enemigo. En armonía con el terror puro, acecha a sus objetivos y revela sus miedos más profundos antes de aplastarlos en la oscuridad';
agentes[5].clase = 'Iniciador';
agentes[5].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[5].habilidades = 5;
habilidades[5].idAgente = 5;
habilidades[5].agente = 'Fade';
habilidades[5].habilidad1_name = 'Capturar';
habilidades[5].habilidad1_description = 'equipa un orbe de tinta de las pesadillas. Puede disparar el orbe para hacerlo caer en picado al suelo después de un tiempo determinado. Al impactar la tinta explotará y creará una zona en la que los enemigos que queden atrapados en ella no podrán escapar por medios normales';
habilidades[5].habilidad1_price = '200 créditos';
habilidades[5].habilidad2_name = 'Atormentar';
habilidades[5].habilidad2_description = 'equipa una entidad de las pesadillas. Puede disparar el orbe para hacerlo caer en picado al suelo después de un tiempo determinado. Al impactar se convertirá en un ente de las pesadillas que revelará la ubicación de los enemigos en su línea de visión. Los enemigos pueden destruir esta entidad';
habilidades[5].habilidad2_price = 'gratuita';
habilidades[5].habilidad3_name = 'Acechadora';
habilidades[5].habilidad3_description = 'te equipas con una Acechadora que puedes lanzar en línea recta. La Acechadora se enfocará en cualquier enemigo o rastro en su cono de visión frontal y lo perseguirá y ofuscará si lo alcanza';
habilidades[5].habilidad3_price = '250 créditos';
habilidades[5].habilidad4_name = 'Anochecer';
habilidades[5].habilidad4_description = 'Fade se equipa con el poder del Miedo. Esto le permite lanzar una onda de energía de las pesadillas que puede atravesar paredes. La energía crea un rastro hacia el oponente, además de ensordecerlo y debilitarlo';
habilidades[5].habilidad4_price = '7 puntos de definitiva';

{ Gekko }
agentes[6].id = 6;
agentes[6].name = 'Gekko';
agentes[6].description = 'Gekko lidera una pequeña pandilla de calamitosas criaturas. Sus colegas toman la delantera para dispersar a los enemigos, mientras que Gekko los persigue para luego reagruparse y repetir el proceso.';
agentes[6].clase = 'Iniciador';
agentes[6].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[6].habilidades = 6;
habilidades[6].idAgente = 6;
habilidades[6].agente = 'Gekko';
habilidades[6].habilidad1_name = 'Wingman';
habilidades[6].habilidad1_description = 'equipa a Wingman. Dispara para mandar a Wingman hacia delante en busca de enemigos. Wingman libera una explosión aturdidora en dirección al primer enemigo que ve. Alterna el modo de disparo mientras apuntas a una zona de la Spike o a una Spike colocada para que Wingman la coloque o la desarme. Para colocarla, Gekko debe tener la Spike en su inventario. Cuando Wingman desaparece, vuelve a su estado de glóbulo en reposo. Intreactúa para recuperar el glóbulo y obtener otra carga de Wingman tras un breve enfriamiento.';
habilidades[6].habilidad1_price = '300 créditos';
habilidades[6].habilidad2_name = 'Dizzy';
habilidades[6].habilidad2_description = 'equipa a Dizzy. Dispara para lanzar a Dizzy volando hacia delante. Dizzy carga y libera explosiones de plasma hacia los enemigos en su campo de visión. El plasma ciega a los enemigos alcanzados. Cuando Dizzy desaparece, vuelve a su estado de glóbulo en reposo. Interactúa para recuperar el glóbulo y obtener otra carga de Dizzy tras un breve enfriamiento';
habilidades[6].habilidad2_price = 'gratuita';
habilidades[6].habilidad3_name = 'Acechadora';
habilidades[6].habilidad3_description = 'te equipas con una Acechadora que puedes lanzar en línea recta. La Acechadora se enfocará en cualquier enemigo o rastro en su cono de visión frontal y lo perseguirá y ofuscará si lo alcanza';
habilidades[6].habilidad3_price = '250 créditos';
habilidades[6].habilidad4_name = 'Anochecer';
habilidades[6].habilidad4_description = 'Fade se equipa con el poder del Miedo. Esto le permite lanzar una onda de energía de las pesadillas que puede atravesar paredes. La energía crea un rastro hacia el oponente, además de ensordecerlo y debilitarlo';
habilidades[6].habilidad4_price = '7 puntos de definitiva';


{ Harbor }
agentes[7].id = 7;
agentes[7].name = 'Harbor';
agentes[7].description = 'Harbor llega al campo de batalla armado con tecnología ancestral capaz de controlar el agua. Libera espumosos torrentes y demoledoras olas para escudar a sus aliados y machacar a quien se interponga en su camino';
agentes[7].clase = 'Controlador';
agentes[7].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[7].habilidades = 7;
habilidades[7].idAgente = 7;
habilidades[7].agente = 'Harbor';
habilidades[7].habilidad1_name = 'Cala';
habilidades[7].habilidad1_description = 'equipa una esfera de agua protectora. Puedes lanzarla de forma estándar o alternar el modo de disparo para lanzarla por debajo del hombro. Al impactar contra el suelo, genera un escudo de agua que bloquea las balas';
habilidades[7].habilidad1_price = '350 créditos';
habilidades[7].habilidad2_name = 'Marea alta';
habilidades[7].habilidad2_description = 'equipa una pared de agua. Puedes dispararla para lanzarla hacia adelante por el suelo. Si mantienes pulsado puedes guiar el agua en la dirección de la mira, atravesando los obstáculos del terreno y creando una pared por todo el recorrido. Alterna el modo de disparo mientras trazas la pared para acabarla antes de tiempo. Los jugadores golpeados se ven ralentizados';
habilidades[7].habilidad2_price = 'gratuita';
habilidades[7].habilidad3_name = 'Cascada';
habilidades[7].habilidad3_description = 'equipa una ola de agua. Dispara para enviarla hacia delante y hacer que atraviese las paredes. Vuelve a usarla para detener la ola. Los jugadores golpeados se ven ralentizados.';
habilidades[7].habilidad3_price = '150 créditos';
habilidades[7].habilidad4_name = 'Ajuste de cuentas';
habilidades[7].habilidad4_description = 'equipas todo el poder de tu artefacto. Dispara para invocar un géiser que nace del suelo. Los enemigos de la zona serán objetivo de varios ataques del géiser. Los jugadores que se vean atrapados por un impacto quedan aturdidos';
habilidades[7].habilidad4_price = '7 puntos de definitiva';

{ Jett }
agentes[8].id = 8;
agentes[8].name = 'Jett';
agentes[8].description = 'Jett es una duelista muy versátil que encantará a los jugadores que buscan velocidad de movimiento y evasión dentro de Valorant. Sus habilidades le otorgan una movilidad por los mapas más alta que los otros personajes, ya que puede impulsarse por los aires o realizar un dash, algo ideal para esquivar una muerte segura o incluso para sorprender a un jugador desprevenido y ganarle ventaja. Además, por todo esto funciona bastante bien aún cuando no seamos muy dados a jugar en equipo combinándonos con nuestros compañeros de escuadrón.';
agentes[8].clase = 'Duelista';
agentes[8].disponibilidad = 'desbloqueado desde el inicio.';
agentes[8].habilidades = 8;
habilidades[8].idAgente = 8;
habilidades[8].agente = 'Jett';
habilidades[8].habilidad1_name = 'Vendaval';
habilidades[8].habilidad1_description = 'Jett se propulsa instantáneamente a mucha altura hacia arriba.';
habilidades[8].habilidad1_price = '150 créditos';
habilidades[8].habilidad2_name = 'Viento de cola';
habilidades[8].habilidad2_description = 'Jett se propulsa de inmediato hacia la dirección en la que se esté moviendo, con mucha rapidez. Si está quieta, se propulsa hacia delante.';
habilidades[8].habilidad2_price = 'gratuita';
habilidades[8].habilidad3_name = 'Borrasca';
habilidades[8].habilidad3_description = 'Lanza un proyectil al instante que se expande en una nube al tocar una superficie, bloqueando la visión brevemente de otros jugadores. Si se mantiene el botón de habilidad pulsado, el humo se curvará en la dirección de la mira.';
habilidades[8].habilidad3_price = '200 créditos';
habilidades[8].habilidad4_name = 'Tormenta de cuchillas';
habilidades[8].habilidad4_description = 'Te equipas con un conjunto de cuchillos volantes de alta precisión que se recargan cuando acabas con un oponente. Puedes disparar cuchillos de uno en uno o, alternando el modo de disparo, puedes lanzar todas las dagas que tengas hacia tu enemigo.';
habilidades[8].habilidad4_price = '7 puntos de definitiva';

{ KAY/O }
agentes[9].id = 9;
agentes[9].name = 'KAY/O';
agentes[9].description = 'KAY/O es una máquina de guerra creada con un solo propósito: neutralizar radiantes. Su poder para suprimir las habilidades enemigas neutraliza la capacidad de sus rivales para contraatacar, un aspecto que le da a él y a sus aliados la ventaja definitiva en la batalla.';
agentes[9].clase = 'Iniciador';
agentes[9].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[9].habilidades = 9;
habilidades[9].idAgente = 9;
habilidades[9].agente = 'KAY/O';
habilidades[9].habilidad1_name = 'Memoria/Flash';
habilidades[9].habilidad1_description = 'Una granada cegadora. La granada cegadora explota después de un breve periodo de tiempo tras lanzarla y ciega a todos en la línea de visión.';
habilidades[9].habilidad1_price = '250 créditos';
habilidades[9].habilidad2_name = 'Punto/Cero';
habilidades[9].habilidad2_description = 'Una cuchilla de supresión lista para lanzar. La cuchilla se pega contra la primera superficie que toca, luego explota y suprime a cualquier oponente que se encuentre en el radio de la explosión.';
habilidades[9].habilidad2_price = 'gratuita';
habilidades[9].habilidad3_name = 'Frag/Mentación';
habilidades[9].habilidad3_description = 'Un fragmento explosivo que se puede disparar para lanzar. El fragmento se pega al suelo y explota varias veces, lo que inflige daño casi mortal en el centro con cada explosión.';
habilidades[9].habilidad3_price = '200 créditos';
habilidades[9].habilidad4_name = 'Null/CMD';
habilidades[9].habilidad4_description = 'Se sobrecarga al instante con energía de radianita polarizada que le da poder a KAY/O y causa que grandes pulsos de energía emanen desde su ubicación. Los enemigos impactados por dichos pulsos quedan suprimidos durante un breve momento.';
habilidades[9].habilidad4_price = '7 puntos de definitiva';

{ Killjoy }
agentes[10].id = 10;
agentes[10].name = 'Killjoy';
agentes[10].description = 'Killjoy es una centinela y una genio que posee un arsenal de inventos entre los que se encuentran unos bots muy interesantes. Sus capacidades la hacen una muy buena opción de cara a asegurar el campo de batalla con facilidad.';
agentes[10].clase = 'Centinela';
agentes[10].nacionalidad = 'Alemania';
agentes[10].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[10].habilidades = 10;
habilidades[10].idAgente = 10;
habilidades[10].agente = 'Killjoy';
habilidades[10].habilidad1_name = 'Bot de alarma';
habilidades[10].habilidad1_description = 'Equipas un bot de alarma camuflado que puedes desplegar para dar caza a los enemigos dentro de su alcance. Cuando alcanza a su objetivo, el bot explota haciendo daño y aplicando vulnerabilidad.';
habilidades[10].habilidad1_price = '200 créditos';
habilidades[10].habilidad2_name = 'Torreta';
habilidades[10].habilidad2_description = 'Equipas una torreta que se despliega en una zona para disparar a todo enemigo que encuentre en un cono de 180 grados.';
habilidades[10].habilidad2_price = 'gratuita';
habilidades[10].habilidad3_name = 'Nanoenjambre';
habilidades[10].habilidad3_description = 'Disparas granadas de nanoenjambre que se camuflan y que puedes activar de forma remota para desplegar un enjambre.';
habilidades[10].habilidad3_price = '200 créditos';
habilidades[10].habilidad4_name = 'Bloqueo';
habilidades[10].habilidad4_description = 'Disparas un dispositivo de bloqueo que detiene a todos los enemigos que estén dentro de su radio de efecto. Los enemigos pueden destruir este dispositivo.';
habilidades[10].habilidad4_price = '7 puntos de definitiva';

{ Neon }
agentes[11].id = 11;
agentes[11].name = 'Neon';
agentes[11].description = 'Elimina a tus enemigos a la velocidad de la luz con Neon. Esta joven duelista puede superar al resto en cuanto a movilidad gracias a su juego de ritmo rápido que combina con descargas de ráfagas y resplandores bioeléctricos.';
agentes[11].clase = 'Duelista';
agentes[11].nacionalidad = 'Filipinas';
agentes[11].disponibilidad = 'bloqueada de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[11].habilidades = 11;
habilidades[11].idAgente = 11;
habilidades[11].agente = 'Neon';
habilidades[11].habilidad1_name = 'Explosión de relé';
habilidades[11].habilidad1_description = 'Lanza instantáneamente un rayo de energía que rebota una vez. Al golpear cada superficie, el rayo electrifica el suelo bajo ella con una explosión aturdidora.';
habilidades[11].habilidad1_price = '200 créditos';
habilidades[11].habilidad2_name = 'A toda máquina';
habilidades[11].habilidad2_description = 'Canaliza instantáneamente el poder de Neon para aumentar su velocidad. Cuando esté cargada, utiliza el disparo alternativo para activar un deslizador eléctrico. La carga del deslizador se reinicia con cada dos asesinatos.';
habilidades[11].habilidad2_price = 'gratuita (2 bajas de recarga)';
habilidades[11].habilidad3_name = 'Carril rápido';
habilidades[11].habilidad3_description = 'Dispara dos líneas de energía hacia delante por el suelo. Dichas líneas se desplazan una corta distancia o hasta chocar contra algún obstáculo. Entonces, las líneas se alzan para convertirse en muros de energía estática que bloquean la visión e infligen daño a los enemigos que los atraviesan.';
habilidades[11].habilidad3_price = '300 créditos';
habilidades[11].habilidad4_name = 'Sobrecarga';
habilidades[11].habilidad4_description = 'Neon desata todo su poder y velocidad durante un breve periodo de tiempo. Disparad para canalizar su poder en un mortífero rayo móvil y preciso. Su duración se reinicia con cada asesinato.';
habilidades[11].habilidad4_price = '7 puntos de definitiva';

{ Omen }
agentes[12].id = 12;
agentes[12].name = 'Omen';
agentes[12].description = 'Omen es una especie de cazador de las sombras que puede ser muy escurridizo en manos hábiles. Especialmente útil si se trabaja en equipo, y un personaje bastante ofensivo con el que hay que tener mucho cuidado si se encuentra en el campo de batalla ya que, por ejemplo, te puede aparecer por sorpresa en la espalda y habrás muerto antes de que te haya dado tiempo a reaccionar.';
agentes[12].clase = 'Controlador';
agentes[12].nacionalidad = 'Desconocida';
agentes[12].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[12].habilidades = 12;
habilidades[12].idAgente = 12;
habilidades[12].agente = 'Omen';
habilidades[12].habilidad1_name = 'Paranoia';
habilidades[12].habilidad1_description = 'Disparar instantáneamente un proyectil sombrío hacia delante que reduce brevemente el alcance de la visión de todos los jugadores que toca y también los ensordece. Este proyectil además puede atravesar paredes.';
habilidades[12].habilidad1_price = '300 créditos';
habilidades[12].habilidad2_name = 'Velo tenebroso';
habilidades[12].habilidad2_description = 'Te equipas con un orbe sombrío y entras en un mundo paralelo para colocarlo y marcar su objetivo. Si lo disparas genera una esfera duradera que bloquea la visión.';
habilidades[12].habilidad2_price = 'gratuita';
habilidades[12].habilidad3_name = 'Aparición tenebrosa';
habilidades[12].habilidad3_description = 'Te equipas con una habilidad que te permite caminar entre las sombras. Al disparar entras en un breve periodo de canalización y después te teletransportas a la ubicación deseada, al hacerlo los enemigos no te verán pero podrán oír el sonido que generas desde la posición de salida.';
habilidades[12].habilidad3_price = '150 créditos';
habilidades[12].habilidad4_name = 'Desde las sombras';
habilidades[12].habilidad4_description = 'Te equipas con un mapa táctico y puedes señalar una ubicación hacia la que quieres teletransportarte. Mientras lo haces Omen aparece como una sombra por el escenario y los enemigos pueden dispararte para cancelar la habilidad.';
habilidades[12].habilidad4_price = '7 puntos de definitiva';

{ Phoenix }
agentes[13].id = 13;
agentes[13].name = 'Phoenix';
agentes[13].description = 'Phoenix es un duelista muy hábil con unas habilidades que lo hacen interesante de cara a la ofensiva. Ideal para los jugadores que quieren ir directos a los tiroteos y conseguirse muchas bajas.';
agentes[13].clase = 'Duelista';
agentes[13].nacionalidad = 'Reino Unido';
agentes[13].disponibilidad = 'desbloqueado desde el inicio.';
agentes[13].habilidades = 13;
habilidades[13].idAgente = 13;
habilidades[13].agente = 'Phoenix';
habilidades[13].habilidad1_name = 'Bola curva';
habilidades[13].habilidad1_description = 'Te equipas con un orbe fulgurante que puedes disparar a izquierda o derecha, explota poco después de lanzarlo y nubla la vista de cualquiera que lo vea.';
habilidades[13].habilidad1_price = '250 créditos';
habilidades[13].habilidad2_name = 'Combustión';
habilidades[13].habilidad2_description = 'Te equipas con una bola de fuego que puedes lanzar para que explote al hacer contacto con una superficie, generando una zona de fuego persistente.';
habilidades[13].habilidad2_price = 'gratuita';
habilidades[13].habilidad3_name = 'Llamarada';
habilidades[13].habilidad3_description = 'Te equipas con una pared de llamas. Puede dispararse para crear una línea de llamas hacia delante que bloquea la visión y quema a los enemigos que la toquen.';
habilidades[13].habilidad3_price = '200 créditos';
habilidades[13].habilidad4_name = 'Cenizas';
habilidades[13].habilidad4_description = 'Colocas al instante un marcador en la posición actual de Phoenix. Mientras está activa, si te matan (o cuando se agota el tiempo) volverás de inmediato a la ubicación del marcador con toda tu vida al completo y las armas recargadas.';
habilidades[13].habilidad4_price = '6 puntos de definitiva';

{ Raze }
agentes[14].id = 14;
agentes[14].name = 'Raze';
agentes[14].description = 'Raze es otra duelista que, como tal, funciona especialmente en la línea más ofensiva de las rondas. Úsala cuando quieras abrir paso a tu equipo y atacar fuertemente sin descanso ni piedad para tus enemigos.';
agentes[14].clase = 'Duelista';
agentes[14].nacionalidad = 'Brasil';
agentes[14].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[14].habilidades = 14;
habilidades[14].idAgente = 14;
habilidades[14].agente = 'Raze';
habilidades[14].habilidad1_name = 'Fardo explosivo';
habilidades[14].habilidad1_description = 'Lanzas un fardo explosivo que se adhiere a las superficies y que puedes activar después para hacer que explote y dañe y desplace a cualquier enemigo que alcance.';
habilidades[14].habilidad1_price = '200 créditos';
habilidades[14].habilidad2_name = 'Balas de pintura';
habilidades[14].habilidad2_description = 'Te equipas con una granada de racimo, puedes dispararla para que explote y se creen submuniciones que infligirán daño a los enemigos alcanzados dentro de su rango.';
habilidades[14].habilidad2_price = 'gratuita';
habilidades[14].habilidad3_name = 'Bot explosivo';
habilidades[14].habilidad3_description = 'Te equipas con un bot explosivo que puedes desplegar en línea recta hacia delante. El bot además rebota en las paredes y si se fija en un enemigo lo perseguirá hasta alcanzarlo y explotar para hacerle gran daño.';
habilidades[14].habilidad3_price = '400 créditos';
habilidades[14].habilidad4_name = 'Cierra telones';
habilidades[14].habilidad4_description = 'Te equipas con un lanzacohetes que puedes disparar para generar un daño en área masivo cuando el cohete entre en contacto con cualquier cosa.';
habilidades[14].habilidad4_price = '8 puntos de definitiva';

{ Reyna }
agentes[15].id = 15;
agentes[15].name = 'Reyna';
agentes[15].description = 'Reyna es una duelista con una capacidad ofensiva muy considerable, capaz de aprovecharse de los orbes que producen sus enemigos muertos para recuperar vida, volverse intangible o incluso invisible al combinar sus habilidades con cabeza.';
agentes[15].clase = 'Duelista';
agentes[15].nacionalidad = 'México';
agentes[15].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[15].habilidades = 15;
habilidades[15].idAgente = 15;
habilidades[15].agente = 'Reyna';
habilidades[15].habilidad1_name = 'Devorar';
habilidades[15].habilidad1_description = 'Los enemigos asesinados por Reyna dejan orbes de alma que duran 3 segundos. Puedes devorar estos orbes para consumirlos al instante y recuperar vida (al obtener 100 puntos de vida con esta habilidad la cantidad adicional decaerá).';
habilidades[15].habilidad1_price = '100 créditos';
habilidades[15].habilidad2_name = 'Despreciar';
habilidades[15].habilidad2_description = 'Consumes instantáneamente un orbe de alma cercano y Reyna se vuelve intangible durante un breve periodo. Si la definitiva está activa, Despreciar te hace también invisible.';
habilidades[15].habilidad2_price = 'gratuita';
habilidades[15].habilidad3_name = 'Mirada lasciva';
habilidades[15].habilidad3_description = 'Te equipas un ojo etéreo destructible. Puedes activarlo para lanzar el ojo hacia delante una corta distancia, limitando la visión de todos los enemigos que lo miren.';
habilidades[15].habilidad3_price = '250 créditos';
habilidades[15].habilidad4_name = 'Emperatriz';
habilidades[15].habilidad4_description = 'Entras en un frenesí que aumenta drásticamente la velocidad de disparo, de equipamiento y de recarga. Consigues cargas infinitas de habilidades de Cosecha de almas. Si consigues un asesinato se reinicia la duración.';
habilidades[15].habilidad4_price = '6 puntos de definitiva';

{ Sage }
agentes[16].id = 16;
agentes[16].name = 'Sage';
agentes[16].description = 'Sage es el personaje sanador o médico de Valorant. Sus habilidades están centradas en la defensa y la curación tanto propia como de compañeros de equipo, e incluso en la reanimación de los caídos, algo que puede cambiar el curso de cualquier ronda que parezca perdida.';
agentes[16].clase = 'Centinela';
agentes[16].nacionalidad = 'China';
agentes[16].disponibilidad = 'desbloqueado desde el inicio.';
agentes[16].habilidades = 16;
habilidades[16].idAgente = 16;
habilidades[16].agente = 'Sage';
habilidades[16].habilidad1_name = 'Orbe de ralentización';
habilidades[16].habilidad1_description = 'Te equipas con un orbe de ralentización que puedes lanzar hacia adelante para que explote al aterrizar, generando un campo persistente que ralentiza a cualquier jugador que lo pise.';
habilidades[16].habilidad1_price = '200 créditos';
habilidades[16].habilidad2_name = 'Orbe de sanación';
habilidades[16].habilidad2_description = 'Te equipas con un orbe de sanación. Puedes usarlo sobre ti para curarte o apuntar a un compañero malherido para otorgarle más salud.';
habilidades[16].habilidad2_price = 'gratuita';
habilidades[16].habilidad3_name = 'Orbe barrera';
habilidades[16].habilidad3_description = 'Te equipas con un orbe barrera que puedes disparar para colocar una pared sólida que bloquea el paso. Se puede rotar la posición de la barrera antes de colocarla.';
habilidades[16].habilidad3_price = '400 créditos';
habilidades[16].habilidad4_name = 'Resurrección';
habilidades[16].habilidad4_description = 'Te permite apuntar a un aliado que haya muerto en la ronda para devolverlo a la vida tras unos instantes y que siga combatiendo con toda la vida al completo.';
habilidades[16].habilidad4_price = '8 puntos de definitiva';

{ Skye }
agentes[17].id = 17;
agentes[17].name = 'Skye';
agentes[17].description = 'Skye es una intrépida soldado procedente del salvaje y hostil territorio de Australia. Tiene una banda de bestias capaces de abrir camino u obstaculizar a los enemigos y además posee poderes para curar a sus aliados. Un equipo en el que esté Skye es más fuerte y seguro.';
agentes[17].clase = 'Iniciador';
agentes[17].nacionalidad = 'Australia';
agentes[17].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[17].habilidades = 17;
habilidades[17].idAgente = 17;
habilidades[17].agente = 'Skye';
habilidades[17].habilidad1_name = 'Precursor';
habilidades[17].habilidad1_description = 'Skye puede invocar a un tigre de Tasmania que es enviado al ataque bajo el control del jugador. Este tigre puede saltar hacia delante y explotar en una conmoción cerebral que daña directamente a todos los enemigos a su alcance.';
habilidades[17].habilidad1_price = '250 créditos';
habilidades[17].habilidad2_name = 'Luz guía';
habilidades[17].habilidad2_description = 'Se equipa con un halcón que puede lanzar hacia delante o guiar en la dirección de su punto de mira. Además, mientras el halcón está en vuelo, puede transformarse en un destello que golpea y confirma si un enemigo estaba dentro de su alcance o línea de visión.';
habilidades[17].habilidad2_price = '250 créditos';
habilidades[17].habilidad3_name = 'Reforestación';
habilidades[17].habilidad3_description = 'Skye saca a relucir sus poderes curativos y canaliza energía recuperando la vida de los aliados que estén dentro de su rango de visión. Se puede reutilizar hasta que se agote la reserva de curación (Skye no puede curarse a sí misma).';
habilidades[17].habilidad3_price = '200 créditos';
habilidades[17].habilidad4_name = 'Buscadores';
habilidades[17].habilidad4_description = 'Invoca a 3 buscadores que son enviados para rastrear enemigos cercanos. Si un buscador alcanza a un rival, le limita su visión.';
habilidades[17].habilidad4_price = '6 puntos de definitiva';

{ Sova }
agentes[18].id = 18;
agentes[18].name = 'Sova';
agentes[18].description = 'Sova es un personaje ideado para los jugadores más "rastreadores". Gracias a sus habilidades y su arco podrás ir siempre un paso por delante de tus enemigos, ya que puedes hacer volar un dron para buscar y marcar oponentes, por ejemplo, o disparar una flecha que emite un pulso durante unos instantes y que resalta el contorno de los enemigos cercanos incluso cuando estos están detrás de las paredes.';
agentes[18].clase = 'Iniciador';
agentes[18].nacionalidad = 'Rusia';
agentes[18].disponibilidad = 'desbloqueado desde el inicio.';
agentes[18].habilidades = 18;
habilidades[18].idAgente = 18;
habilidades[18].agente = 'Sova';
habilidades[18].habilidad1_name = 'Flecha explosiva';
habilidades[18].habilidad1_description = 'Te equipas con un arco de flechas explosivas. Puedes apuntar y disparar para lanzar la flecha hacia delante, al impactar sobre una superficie explotará y hará daño a enemigos cercanos. Si mantienes pulsado el botón de apuntar se amplía el alcance de la flecha. Y si alternas el modo de disparo puedes llegar a crear hasta dos rebotes del proyectil, algo genial para que las flechas lleguen más lejos.';
habilidades[18].habilidad1_price = '150 créditos';
habilidades[18].habilidad2_name = 'Proyectil de reconocimiento';
habilidades[18].habilidad2_description = 'Te equipas con un arco con flechas de reconocimiento. Puedes disparar la flecha y cuando esta impacte se activará y revelará en un área cercana la posición de los enemigos que detecte, solo por unos instantes (y esta flecha puede ser destruida). Si mantienes pulsado el botón de apuntar se amplía el alcance de la flecha. Y si alternas el modo de disparo puedes llegar a crear hasta dos rebotes del proyectil.';
habilidades[18].habilidad2_price = 'Gratuita';
habilidades[18].habilidad3_name = 'Dron de reconocimiento';
habilidades[18].habilidad3_description = 'Te equipas con un dron de reconocimiento. Puedes usarlo para que se despliegue y controlar su vuelo (aunque eso deja a Sova quieto en su posición, hazlo solo cuando sepas que estás a salvo o a cubierto). Se permite controlar el dron durante unos segundos y puedes disparar un dardo marcador que revelará la posición de cualquier enemigo al que alcance.';
habilidades[18].habilidad3_price = '400 créditos';
habilidades[18].habilidad4_name = 'Furia del cazador';
habilidades[18].habilidad4_description = 'Te equipas con un arco especial de proyectiles de energía de largo alcance. Este tipo de flecha atraviesa las paredes y además de infligir bastante daño puede revelar la posición de los enemigos que se encuentren a su paso. Se puede usar hasta 3 veces mientras el temporizador de la habilidad está activo.';
habilidades[18].habilidad4_price = '8 puntos de definitiva';

{Viper}
agentes[19].id = 19;
agentes[19].name = 'Viper';
agentes[19].description = 'Viper es una agente centrada en aspectos tóxicos y venenosos que puede hacer mucho daño si eres diestro con ella. En especial gustará a los jugadores que quieran ir más a sus anchas sin depender tanto del juego en equipo, aunque bien usada puede apoyar bastante a los compañeros.';
agentes[19].clase = 'Controlador';
agentes[19].nacionalidad = 'EE.UU.';
agentes[19].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[19].habilidades = 19;
habilidades[19].idAgente = 19;
habilidades[19].agente = 'Viper';
habilidades[19].habilidad1_name = 'Nube venenosa';
habilidades[19].habilidad1_description = 'Te equipas con una granada de gas que puedes lanzar para que permanezca durante toda la ronda. Al activarla liberarás una nube de gas tóxico a cambio de combustible. La granada se puede usar más de una vez o incluso recoger para recolocarla.';
habilidades[19].habilidad1_price = '200 créditos';
habilidades[19].habilidad2_name = 'Pantalla tóxica';
habilidades[19].habilidad2_description = 'Te equipas con un lanzagranadas de gas con el que puedes disparar una larga hilera de granadas. Al activarla creas un muro de gas tóxico a cambio de combustible.';
habilidades[19].habilidad2_price = 'Gratuita';
habilidades[19].habilidad3_name = 'Veneno de serpiente';
habilidades[19].habilidad3_description = 'Te equipas con un lanzador químico. Puedes disparar un cartucho que se rompe al impactar contra el suelo, lo que genera una zona química persistente que daña y ralentiza a los enemigos.';
habilidades[19].habilidad3_price = '200 créditos';
habilidades[19].habilidad4_name = 'Pozo de víbora';
habilidades[19].habilidad4_description = 'Te equipas con un pulverizador químico que puedes disparar para pulverizar una nube química en todas las direcciones alrededor de Viper. Esto genera una gran nube que reduce el alcance de la visión y la vida máxima de los jugadores que se encuentren dentro.';
habilidades[19].habilidad4_price = '7 puntos de definitiva';

{ Yoru }
agentes[20].id = 20;
agentes[20].name = 'Yoru';
agentes[20].description = 'Yoru abre agujeros en el tejido de la realidad para infiltrarse tras las líneas enemigas sin ser visto. Utiliza el engaño y la agresividad por igual para acabar con sus objetivos antes de que sepan qué ha pasado.';
agentes[20].clase = 'Duelista';
agentes[20].nacionalidad = 'Japón';
agentes[20].disponibilidad = 'bloqueado de inicio (puede conseguirse mediante su contrato o pagando 1000 puntos Valorant).';
agentes[20].habilidades = 20;
habilidades[20].idAgente = 20;
habilidades[20].agente = 'Yoru';
habilidades[20].habilidad1_name = 'Punto ciego';
habilidades[20].habilidad1_description = 'Arrancas un fragmento dimensional inestable de la realidad, al lanzarlo activa un destello que se carga al impactar contra una superficie sólida.';
habilidades[20].habilidad1_price = '250 créditos';
habilidades[20].habilidad2_name = 'Infiltración';
habilidades[20].habilidad2_description = 'Preparas un vínculo de grietas, se puede lanzar hacia adelante para teletransportarte a la ubicación o colocarlo en algún lugar en concreto.';
habilidades[20].habilidad2_price = 'Gratuita';
habilidades[20].habilidad3_name = 'Engaño';
habilidades[20].habilidad3_description = 'Te equipas un eco que imita el sonido de pisadas cuando se activa. Puedes activarlo y enviarlo hacia delante o colocarlo en un sitio.';
habilidades[20].habilidad3_price = '100 créditos';
habilidades[20].habilidad4_name = 'Viaje interdimensional';
habilidades[20].habilidad4_description = 'Te colocas una máscara que permite ver entre dimensiones, los enemigos que estén fuera no podrán verte ni hacerte daño.';
habilidades[20].habilidad4_price = '7 puntos de definitiva';
}
{ Haven }
mapas[1].name := 'Haven';
mapas[1].localizacion := 'La isla de Venecia, Italia';
mapas[1].fecha_lanzamiento := '2 de junio de 2020';
mapas[1].description := 'Haven es un mapa grande y abierto con tres sitios de bomba. Su diseño permite varias rutas de ataque y defensa, así como oportunidades para flanquear al enemigo. Los tres sitios de bomba ofrecen diferentes desafíos estratégicos, y los jugadores deben adaptarse rápidamente a los cambios en el flujo del juego. Las áreas abiertas proporcionan espacio para el combate a larga distancia, mientras que los pasillos estrechos y las esquinas ofrecen oportunidades para el combate cuerpo a cuerpo. Haven es un mapa dinámico que fomenta la comunicación y la coordinación entre los miembros del equipo.'

{ Icebox }
{
mapas[2].name := 'Icebox';
mapas[2].localizacion := 'El Ártico';
mapas[2].fecha_lanzamiento := '13 de octubre de 2020';
mapas[2].description := 'Icebox es un mapa ambientado en una instalación de investigación en el Ártico. Su diseño único presenta múltiples niveles y pasajes estrechos, lo que lo convierte en un desafío tanto para atacantes como para defensores. El terreno irregular y las áreas elevadas ofrecen oportunidades para el combate a larga distancia, mientras que los pasillos estrechos y las zonas interiores son propicias para el combate cuerpo a cuerpo. Icebox fomenta la creatividad y el trabajo en equipo, ya que los jugadores deben adaptarse a un entorno cambiante y aprovechar al máximo sus habilidades y recursos.'

{ Bind }
mapas[3].name := 'Bind';
mapas[3].localizacion := 'Marruecos';
mapas[3].fecha_lanzamiento := '2 de junio de 2020';
mapas[3].description := 'Bind es un mapa ubicado en Marruecos que presenta una mezcla de áreas interiores y exteriores. Su diseño simétrico ofrece oportunidades para flanquear al enemigo y controlar el flujo del juego. Los dos sitios de bomba presentan desafíos únicos para atacantes y defensores, y los pasillos estrechos y las esquinas ofrecen oportunidades para el combate cercano. Bind fomenta la comunicación y la coordinación entre los miembros del equipo, ya que los jugadores deben trabajar juntos para asegurar la victoria.'

{ Breeze }
mapas[4].name := 'Breeze';
mapas[4].localizacion := 'Bermudas';
mapas[4].fecha_lanzamiento := '27 de abril de 2021';
mapas[4].description := 'Breeze es un mapa tropical situado en las Bermudas. Su diseño expansivo y sus amplias áreas abiertas ofrecen oportunidades para el combate a larga distancia y estrategias de flanqueo. Los tres sitios de bomba presentan desafíos únicos para atacantes y defensores, y las áreas interiores ofrecen oportunidades para el combate cercano. Breeze es un mapa dinámico que fomenta la exploración y la adaptabilidad, ya que los jugadores deben estar preparados para enfrentarse a diferentes situaciones en cada ronda.'

{ Ascent }
mapas[5].name := 'Ascent';
mapas[5].localizacion := 'Venecia, Italia';
mapas[5].fecha_lanzamiento := '2 de junio de 2020';
mapas[5].description := 'Ascent es un mapa ubicado en la ciudad de Venecia, Italia. Su diseño simétrico y sus amplias áreas abiertas ofrecen oportunidades para el combate a larga distancia y estrategias de flanqueo. Los dos sitios de bomba presentan desafíos únicos para atacantes y defensores, y las áreas interiores ofrecen oportunidades para el combate cercano. Ascent es un mapa dinámico que fomenta la comunicación y la coordinación entre los miembros del equipo, ya que los jugadores deben trabajar juntos para asegurar la victoria.'

{ Fracture }
mapas[6].name := 'Fracture';
mapas[6].localizacion := 'Desconocida';
mapas[6].fecha_lanzamiento := '14 de octubre de 2021';
mapas[6].description := 'Fracture es un mapa futurista con un diseño asimétrico. Presenta una división central que separa el mapa en dos partes distintas, lo que ofrece oportunidades para flanquear al enemigo y controlar el flujo del juego. Los dos sitios de bomba presentan desafíos únicos para atacantes y defensores, y los pasajes estrechos y las áreas abiertas ofrecen una variedad de opciones tácticas. Fracture es un mapa dinámico que fomenta la creatividad y el trabajo en equipo, ya que los jugadores deben adaptarse a un entorno cambiante y aprovechar al máximo sus habilidades y recursos.'
}
  }
end;

end.

