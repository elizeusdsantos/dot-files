#!/bin/bash

# Definir os contextos disponíveis
DEV_CONTEXT="arn:aws:eks:us-east-1:149536464530:cluster/Aplicap-DEV-US-EKS"
SA_CONTEXT="arn:aws:eks:sa-east-1:149536464530:cluster/Aplicap-SA-EKS"

# Função para exibir ajuda
usage() {
    echo "Uso: kctx [devus|prdsa]"
    echo "  devus - Alterna para o contexto DEV (us-east-1)"
    echo "  prdsa  - Alterna para o contexto SA (sa-east-1)"
    exit 1
}

# Verificar se foi passado um argumento
if [ $# -ne 1 ]; then
    usage
fi

# Alternar para o contexto correto
case "$1" in
    devus)
        echo "Alternando para o contexto DEV-US..."
        kubectl config use-context "$DEV_CONTEXT"
        ;;
    prdsa)
        echo "Alternando para o contexto PRD-SA..."
        kubectl config use-context "$SA_CONTEXT"
        ;;
    *)
        usage
        ;;
esac
