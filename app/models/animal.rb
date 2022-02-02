class Animal < ApplicationRecord
  belongs_to :ong

  def self.get_animais(params, user_id_logado)
    lista_ongs = verifica_usuario_logado(user_id_logado)
    if (params.keys.include?('animal'))
      if params[:animal][:nome].present?
        ongs_ids = lista_ongs.to_s.gsub("[","(").gsub("]",")")
        Animal.where("nome like '%#{params[:animal][:nome]}%' and ong_id in #{ongs_ids}")
      end  
    else
      Animal.where(ong_id: lista_ongs)    
    end
  end  

  def self.verifica_usuario_logado(user_id_logado)
    lista_ongs_id = ''
    user_id = User.find(user_id_logado)
    if user_id.present?
      ongs = Ong.where(user_id: user_id)
      if ongs.present?
        lista_ongs_id = ongs.map{|ong| ong.id }
      end  
    end
    lista_ongs_id  
  end  
end
