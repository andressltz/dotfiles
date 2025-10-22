alias setEnv="setEnviroment"

setEnviroment() {
    extractValueXml() {
        local tag="$1"
        grep "<$tag>" pom.xml | sed -E "s/.*<$tag>([^<]+)<\/$tag>.*/\1/" | head -n1
    }

    if [[ -f "pom.xml" ]]; then
        echo "🟢 Projeto Maven detectado."

        JAVA_VERSION=$(extractValueXml "java.version")

        if [[ -z "$JAVA_VERSION" ]]; then
            echo "⚠️ Versão Java não encontrada no <java.version>, procurando no maven."
            JAVA_VERSION=$(grep -A1 "<maven.compiler.source>" pom.xml | tail -n1 | sed -E 's/.*<[^>]+>([^<]+)<.*/\1/')
        fi

        if [[ -z "$JAVA_VERSION" ]]; then
            echo "⚠️ Versão Java não especificada no pom.xml. Usando versão do sistema."
            JAVA_VERSION_RAW=$(java -version 2>&1 | head -n1)
            JAVA_VERSION=$(echo "$JAVA_VERSION_RAW" | grep -oE '([0-9]+(\.[0-9]+)?)' | head -n1)
        fi

        echo "➡️ Versão Java detectada no projeto: $JAVA_VERSION"

        case "$JAVA_VERSION" in
            "1.8"|"8")
            echo "🔧 Executando: java8"
            java8
            ;;
            "11")
            echo "🔧 Executando: java11"
            java11
            ;;
            "17")
            echo "🔧 Executando: java17"
            java17
            ;;
            "21")
            echo "🔧 Executando: java21"
            java21
            ;;
            *)
            echo "⚠️ Versão Java $JAVA_VERSION não mapeada — ajuste o script se necessário."
            ;;
        esac

    elif [[ -f "package.json" ]]; then
        echo "🟢 Projeto Node.js detectado."

        NODE_VERSION=$(grep -oP '"node"\s*:\s*"[^"]+"' package.json | grep -oP '[0-9]+(\.[0-9]+){0,2}' | head -n1)

        if [[ -n "$NODE_VERSION" ]]; then
            echo "➡️ Versão Node definida no package.json: $NODE_VERSION"
            echo "🔧 Executando: mvn use $NODE_VERSION"
            mvn use "$NODE_VERSION"
        else
            echo "⚠️ Nenhuma versão de Node especificada em package.json."
            echo "ℹ️ Tentando detectar versão atual instalada..."
            node -v
        fi

    else
        echo "❌ Nenhum pom.xml ou package.json encontrado neste diretório."
        return 1
    fi
}