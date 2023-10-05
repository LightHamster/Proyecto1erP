#!\bin\bash

# Verificar si se proporciona el parámetro -a o -t
if [ $# -ne 1 ]; then
    echo "Uso: $0 [-a | -t]"
    exit 1
fi

# Verificar si el parámetro es -a o -t
if [ "$1" == "-a" ]; then
    tema="Agile"
    archivo="agile.inf"
elif [ "$1" == "-t" ]; then
    tema="Metodologías Tradicionales"
    archivo="tradicionales.inf"
else
    echo "Opción no válida: $1"
    exit 1
fi

while true; do
    clear
    echo "Bienvenido a la guía rápida de $tema, para continuar seleccione un tema:"
    echo ""
    echo "SCRUM"
    echo "X.P."
    echo "Kanban"
    echo "Crystal"
    echo ""
    read -p "Elija una opción (o escriba 'q' para salir): " opcion

    case $opcion in
        "SCRUM"|"X.P."|"Kanban"|"Crystal")
            seccion="$opcion"
            ;;
        "q")
            exit 0
            ;;
        *)
            echo "Opción no válida."
            continue
            ;;
    esac

    while true; do
        clear
        echo "Usted está en la sección $seccion, seleccione la opción que desea utilizar:"
        echo ""
        echo "Agregar información"
        echo "Buscar"
        echo "Eliminar información"
        echo "Leer base de información"
        echo ""
        read -p "Elija una opción (o escriba 'q' para volver al menú anterior): " opcion_seccion

        case $opcion_seccion in
            "Agregar información")
                read -p "Ingrese el identificador del concepto: " identificador
                read -p "Ingrese la definición: " definicion
                echo "[$identificador] .- $definicion" >> "$archivo"
                echo "Información agregada correctamente."
                ;;
            "Buscar")
                read -p "Ingrese el elemento a buscar: " elemento
                grep -i "\[$elemento\]" "$archivo"
                ;;
            "Eliminar información")
                read -p "Ingrese el concepto a eliminar: " concepto
                sed -i "/\[$concepto\]/d" "$archivo"
                echo "Información eliminada correctamente."
                ;;
            "Leer base de información")
                cat "$archivo"
                ;;
            "q")
                break
                ;;
            *)
                echo "Opción no válida."
                ;;
        esac
    done
done
