class Book < ApplicationRecord
    belongs_to :user
    belongs_to :author

    validate :author_must_belong_to_same_user

    # Devolver `all` quando não há filtro deixa as chamadas encadeáveis:
    # o controller não precisa de if para cada parâmetro.
    def self.search_title(term)
        return all if term.blank?

        where("title LIKE ?", "%#{sanitize_sql_like(term)}%")
    end

    def self.by_read_status(status)
        case status
        when "read"   then where(read: true)
        when "unread" then where(read: [ false, nil ])
        else all
        end
    end

    private
        # O <select> do formulário já só lista os autores do usuário, mas um POST
        # forjado com o author_id de outra pessoa passaria sem esta checagem.
        def author_must_belong_to_same_user
            return if author.nil? || user_id.nil?

            errors.add(:author_id, "não pertence a você") unless author.user_id == user_id
        end
end
