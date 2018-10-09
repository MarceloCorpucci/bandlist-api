class MemberSerializer

  def initialize(member)
    @member = member
  end

  def as_json(*)
    data = {
      name: @member.name,
      role: @member.role,
      alive: @member.alive
    }
    data[:errors] = @member.errors if @member.errors.any?
    data
  end

end