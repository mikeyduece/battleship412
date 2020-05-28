module Games
  class GameOverError < Base
    def code
      super
    end

    def message
      I18n.t('api.games.errors.game_over')
    end
  end
end