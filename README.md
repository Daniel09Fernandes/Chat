# Chat
Chat para ungui


Comportamento do chat
Para o projeto atua, o chat se comporta da seguinte maneira:

Na tabela tb_chat_client, os usuarios são liberados para ter acesso, ao liberar, o validador já deixa o usuario "cadastrado",

Dentro do meu projeto particular, na main, coloquei um verifica msg com esta SQL: 'Select Visualizado from tb_chat_msg where para=:id and COALESCE(visualizado,'''')<>''S'' '

caso não visualizado, dispara um alerta ao usuário logado, que há uma nova mensagem.
Adição de emotion, e aceita envio de imagem.
double check de leitura.
Adição de conversa em grupos (em desenvolvimento ainda, porem funcionando)
tema utilizado mainmodule : uni_mac_yosemite
