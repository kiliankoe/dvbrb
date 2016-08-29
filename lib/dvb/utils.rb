module DVB

  def self.parse_mode(mode)
    if mode.is_i?
      mode = mode.to_i
      return TransportMode::TRAM if mode.between?(0, 59)
      return TransportMode::CITYBUS if mode.between?(60, 99)
      return TransportMode::REGIOBUS if mode.between?(100, 1000)
    end

    return TransportMode::LIFT if mode == 'SWB'

    if /^E(\d+)/.match(mode)
      match = /^E(\d+)/.match(mode)
      # binding.pry
      return TransportMode::TRAM if match[1].to_i <= 59
      return TransportMode::CITYBUS
    end

    return TransportMode::REGIOBUS if /^\D$|^\D\/\D$/.match(mode)
    return TransportMode::FERRY if /^F/.match(mode)
    return TransportMode::TRAIN if /^RE|^IC|^TL|^RB|^SB|^SE|^U\d/.match(mode)
    return TransportMode::METROPOLITAN if /^S/.match(mode)
    return TransportMode::AST if /alita/.match(mode)

    nil
  end

  class TransportMode
    TRAM = {
      title: 'Straßenbahn',
      name: 'tram',
      icon_url: 'https://www.dvb.de/assets/img/trans-icon/transport-tram.svg'
    }
    CITYBUS = {
      title: 'Stadtbus',
      name: 'citybus',
      icon_url: 'https://www.dvb.de/assets/img/trans-icon/transport-citybus.svg'
    }
    REGIOBUS = {
      title: 'Regionalbus',
      name: 'regiobus',
      icon_url: 'https://www.dvb.de/assets/img/trans-icon/transport-bus.svg'
    }
    METROPOLITAN = {
      title: 'S-Bahn',
      name: 'metropolitan',
      icon_url: 'https://www.dvb.de/assets/img/trans-icon/transport-metropolitan.svg'
    },
    LIFT = {
      title: 'Seil-/Schwebebahn',
      name: 'lift',
      icon_url: 'https://www.dvb.de/assets/img/trans-icon/transport-lift.svg'
    },
    FERRY = {
      title: 'Fähre',
      name: 'ferry',
      icon_url: 'https://www.dvb.de/assets/img/trans-icon/transport-ferry.svg'
    },
    AST = {
      title: 'Anrufsammeltaxi (AST)/ Rufbus',
      name: 'ast',
      icon_url: 'https://www.dvb.de/assets/img/trans-icon/transport-alita.svg'
    },
    TRAIN = {
      title: 'Zug',
      name: 'train',
      icon_url: 'https://www.dvb.de/assets/img/trans-icon/transport-train.svg'
    }
  end

end

class String
  def is_i?
    /\A[-+]?\d+\z/ === self
  end
end
