module Games
  class InvalidTurnError < Base

    def code
      404
    end

    def message
      I18n.t('api.games.errors.invalid_turn')
    end
  end
end