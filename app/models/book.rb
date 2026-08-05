class Book < ApplicationRecord
    belongs_to :user
    belongs_to :author

    validate :author_must_belong_to_same_user

    private
        # O <select> do formulário já só lista os autores do usuário, mas um POST
        # forjado com o author_id de outra pessoa passaria sem esta checagem.
        def author_must_belong_to_same_user
            return if author.nil? || user_id.nil?

            errors.add(:author_id, "não pertence a você") unless author.user_id == user_id
        end
end
