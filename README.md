# Chat - Client/Server
Chat ungui, para acoplar ao seu ERP/Projeto


# Comportamento do chat
Para o projeto atua, o chat se comporta da seguinte maneira:

Na tabela tb_chat_client, os usuarios são liberados para ter acesso, ao liberar, o validador já deixa o usuario "cadastrado",

Dentro do meu projeto particular, na main, coloquei um verifica msg com esta SQL: 'Select Visualizado from tb_chat_msg where para=:id and COALESCE(visualizado,'''')<>''S'' '

caso não visualizado, dispara um alerta ao usuário logado, que há uma nova mensagem.
Adição de emotion, e aceita envio de imagem.
double check de leitura.
Adição de conversa em grupos (em desenvolvimento ainda, porem funcionando)
tema utilizado mainmodule : uni_mac_yosemite


# Para rodar o pas/dfm
*** deve adequar as uses e criar as tabelas referente ***

--- Tabelas necessárias, banco utilizado postgresSQL, porem pode ser montado esta estrutura em qualquer BD ---
CREATE TABLE public.tb_chat_client ( id_usuario INTEGER NOT NULL, gid_msg VARCHAR(38) NOT NULL, departamento VARCHAR(20), status VARCHAR(8), msg_lida CHAR(1), desativado BOOLEAN, dir_img VARCHAR(200), CONSTRAINT "tb_chat_client_GID_MSG_key" UNIQUE(gid_msg), CONSTRAINT "tb_chat_client_ID_USUARIO_key" UNIQUE(id_usuario), CONSTRAINT tb_chat_client_pkey PRIMARY KEY(id_usuario, gid_msg) ) WITH (oids = false);

CREATE TABLE public.tb_chat_grupo_msg ( id_grupo INTEGER NOT NULL, msg BYTEA, id_msg_enviada INTEGER NOT NULL, id SERIAL, data DATE, hora TIME(0) WITHOUT TIME ZONE ) WITH (oids = false);

CREATE TABLE public.tb_chat_grupo_participantes ( id_grupo INTEGER NOT NULL, id_participante INTEGER NOT NULL, CONSTRAINT tb_chat_grupo_participantes_idx UNIQUE(id_participante, id_grupo), CONSTRAINT tb_chat_grupo_participantes_fk FOREIGN KEY (id_participante) REFERENCES public.tb_chat_client(id_usuario) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE, CONSTRAINT tb_chat_grupo_participantes_fk1 FOREIGN KEY (id_grupo) REFERENCES public.tb_chat_grupos(id_grupo) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE ) WITH (oids = false);

ALTER TABLE public.tb_chat_grupo_participantes ALTER COLUMN id_participante SET STATISTICS 0;

CREATE TABLE public.tb_chat_grupos ( id_grupo INTEGER NOT NULL, "Nome" VARCHAR(50) NOT NULL, CONSTRAINT tb_chat_grupos_pkey UNIQUE(id_grupo, "Nome") ) WITH (oids = false);

CREATE UNIQUE INDEX tb_chat_grupos_id_grupo_key ON public.tb_chat_grupos USING btree (id_grupo);

CREATE TABLE public.tb_chat_msg ( de INTEGER NOT NULL, para INTEGER NOT NULL, msg BYTEA, gid_msg VARCHAR(38) NOT NULL, data DATE, visualizado VARCHAR(1), hora TIME(0) WITHOUT TIME ZONE ) WITH (oids = false);

COMMENT ON COLUMN public.tb_chat_msg.gid_msg IS 'mescla de 19 posições do gid do owner e 19 posições do gid do receptor';

A validação de usuário, deve se adequar a tabela de controle de usuário de cada projeto individual. (Função valida usuário utilizada no formShow)

uses uFuncoesUnigui.pas {não estou enviando junto} Porém as funções consumidas desta class, são :

function iif(condicao: Boolean; value1, value2: variant): Variant; begin if (condicao) then result := value1 else result := value2 end;

// gera sequencias postgresSQL function GeraCodigo(qry: TADQuery; sequence: string): integer; begin try qry.Close; qry.SQL.Text := 'select nextval(' + QuotedStr(sequence) + ')'; qry.Open; Result := qry.Fields[0].AsInteger; except on e: exception do raise Exception.Create('Erro ao gerar código !' + sLineBreak + e.Message); end; end;
