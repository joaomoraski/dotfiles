setopt auto_cd

# JAVA HOME EXPORTS
# export JAVA_TOOL_OPTIONS="-XX:HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/java_pid<pid>.hprof -XX:HeapDumpSize=2g"
export ANDROID_TOOLS=/home/moraski/Android/Sdk/platform-tools
export ANDROID_HOME=/home/moraski/Android/Sdk
export JAVA_HOME=/home/moraski/dev/jdk1.8.0_351
export MAVEN_HOME=/home/moraski/dev/apache-maven-3.6.3
export MAVEN_REPO_SERVER=local
export MAVEN_REPO_URL=http://localhost:8080/manager/text
export MAVEN_REPO_USER=dev
export MAVEN_REPO_PASS=dev
export GOROOT=/usr/local/go
export PATH=$PATH:$ANDROID_TOOLS:$JAVA_HOME/bin:$MAVEN_HOME/bin:/usr/local/go/bin:/home/moraski/go/bin
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/trabalho/constant-crow-400212-2b6bf83a7435.json
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="bira"
#ZSH_THEME="agnoster"
#ZSH_THEME="bullet-train"
ZSH_THEME="bira"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Removed git because it was useless aliases (and conflict with gr)

# plugins
plugins=(git zsh-autosuggestions docker kubectl mvn)
# TODO: argo
# ansible nmap postgres aws heroku
# yarn npm npx react-native 
# pip python virtualenv autopep8
# mvn 
# ruby gem rails rbenv bundler rvm 
# Seems to not work: pip yarn docker-compose npm npx

source $ZSH/oh-my-zsh.sh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Functions alias
previsao(){
    if [ -z "$1" ];
        then
            curl https://wttr.in/Campo%20Mour%C3%A3o
        else 
            curl https://wttr.in/$1
    fi
}

arquivoAndroid(){
    if [ -z "$1" ];
        then
            echo "faz essa porra direito ai amigao, passa o parametro certo"
        else 
            adb pull $1 
    fi
}

meet(){
    if [ "$(date '+%A')" = "sexta" ] ; then
        google-chrome-stable --new-window 'https://meet.google.com/cba-kiat-hvn?authuser=1'
    else
        google-chrome-stable --new-window 'https://meet.google.com/yxj-yukm-mky?authuser=1'
    fi
}

commitEmergencia(){
    if [ -z "$1" ];
        then
            cd /home/moraski/trabalho/onsafety && git add . && git commit -m "commit de emergencia" && git push
        else 
            cd /home/moraski/trabalho/onsafety && git add . && git commit -m $1 && git push
    fi
}

ns() {
  k config set-context --current --namespace=$1
} 


klogin_zone() {
  ctx=$1
  project=$2
  cluster=$3
  region=$4
  old_ctx="gke_"$project"_"$region"_"$cluster
  
  kubectl config use-context $ctx 2>/dev/null
  # RESULT=$?
  # if [ $RESULT -gt 0 ]; then
  gcloud container clusters get-credentials $cluster --zone $region --project $project
  kubectl config rename-context $old_ctx $ctx
  # fi
}

rpt() {
 watch -c "zsh -c 'source ~/.zshrc; onsafety_; $@'"
}

onsafety_() {
 green "$(figlet onsafety)"
}

RED_B='\e[1;91m'
GREEN_B='\e[1;92m'
YELLOW_B='\e[1;93m'
BLUE_B='\e[1;94m'
PURPLE_B='\e[1;95m'
CYAN_B='\e[1;96m'
WHITE_B='\e[1;97m'
RESET='\e[0m'

red() { echo -e "${RED_B}${1}${RESET}"; }
green() { echo -e "${GREEN_B}${1}${RESET}"; }
yellow() { echo -e "${YELLOW_B}${1}${RESET}"; }
blue() { echo -e "${BLUE_B}${1}${RESET}"; }
purple() { echo -e "${PURPLE_B}${1}${RESET}"; }
cyan() { echo -e "${CYAN_B}${1}${RESET}"; }
white() { echo -e "${WHITE_B}${1}${RESET}"; }


# Função para obter o namespace atual do Kubernetes
get_k8s_namespace() {
    # Use o kubectl para obter o namespace atual
    local namespace
    namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    if [ -n "$namespace" ]; then
        echo "$namespace"
    fi
}

get_gcloud_project() {
    # Use o gcloud para obter o nome do projeto do GCP
    local project
    project=$(gcloud config get-value project 2>/dev/null)
    if [ -n "$project" ]; then
        # Use um comando de texto para remover números e o hífen no final
        project=$(echo "$project" | sed 's/[0-9-]*$//')
        echo "$project"
    fi
}


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliase
# alias zshconfig="mate ~/.zshrc"
alias pip=pip3
alias trabalho='~/trabalho/onsafety'
alias onsafety-hazelcast="klogin_zone onsafety-hazelcast constant-crow-400212 gke-cluster southamerica-east1-b"
alias onsafety-projeto-hazel="gcloud config set project constant-crow-400212"
alias onsafety-dev="klogin_zone onsafety-dev api-project-177768904403 gke-cluster southamerica-east1-b"
alias onsafety-projeto-dev="gcloud config set project api-project-177768904403"
alias desk='~/Desktop'
alias chrome="google-chrome-stable"
alias twitter="chrome www.twitter.com"
alias github="chrome www.github.com/joaomoraski"
alias lcllaravel="chrome http://localhost:8000"
alias lclonsafety="chrome http://localhost:8080"
alias speedtest="speedtest-cli"
alias rmb="rm ~/.zsh_history | rm ~/.mysql_history | rm ~/.bash_history"
alias rmm="rm -rfd"
alias mysql="mysql -u root -proot"
alias mysqlmob="mysql -u root -proot moblean"
alias compress='tar -czvf ' # Nome e o arquivo a ser compactado
alias decompress='tar -xzvf ' # Nome do arquivo para decompress
alias adb='/home/moraski/Android/Sdk/platform-tools/./adb'
alias snake='ruben-snake-cmd'
alias ports='sudo lsof -i -P -n'
alias facul='cd /home/moraski/faculdade/'
alias lampada='cd /home/moraski/dev/util/yeelight/ && source .venv/bin/activate && python3 main.py'
alias matlab='/usr/local/MATLAB/R2023a/bin/./matlab'
alias getpod="rpt kubectl get pod"
alias getpodw="rpt kubectl get pod -o wide"
alias sonar="sh /home/moraski/trabalho/sonarqube/bin/linux-x86-64/sonar.sh console"
alias godot="/home/moraski/dev/./Godot &"
alias onsafety-hazelcast="klogin_zone onsafety-hazelcast constant-crow-400212 gke-cluster southamerica-east1-b"
alias onsafety-projeto-hazel="gcloud config set project constant-crow-400212"
alias onsafety-dev="klogin_zone onsafety-dev api-project-177768904403 gke-cluster southamerica-east1-b"
alias onsafety-projeto-dev="gcloud config set project api-project-177768904403"
alias vproj="gcloud config list"
alias deploy="/home/moraski/trabalho/onsafety-deploy/onsafety/gke/dev && vproj"
# Completion for the d2s python client: https://pypi.org/project/d2s/
#eval "$(_D2S_COMPLETE=source_zsh d2s)"
