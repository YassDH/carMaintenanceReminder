package jwt;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import models.User;
import play.mvc.Http;
import repositories.UsersRepository;

import javax.inject.Inject;
import java.io.UnsupportedEncodingException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.Optional;

public class JwtAuth {
    private static final String JWT_SECRET = "9b0214fbbbb7218ec59ca64d508ed4cb330a52ae79305aea977858192e3781cf";
    private final JWTVerifier verifier;
    private final UsersRepository usersRepository;
    @Inject
    public JwtAuth(UsersRepository usersRepository) throws UnsupportedEncodingException {
        this.usersRepository = usersRepository;
        verifier = JWT.require(Algorithm.HMAC256(JWT_SECRET))
                .build();
    }

    public String generateToken(Long userID) throws UnsupportedEncodingException {
        long expirationTimeInMinutes = 120; // 2 hours expiration
        return JWT.create()
                .withClaim("userId", userID)
                .withExpiresAt(Date.from(ZonedDateTime.now(ZoneId.systemDefault()).plusMinutes(expirationTimeInMinutes).toInstant()))
                .sign(Algorithm.HMAC256(JWT_SECRET));
    }

    public boolean isValidToken(String token) throws UnsupportedEncodingException{
        try {
            DecodedJWT jwt = verifier.verify(token);
            return true;
        } catch (JWTVerificationException exception) {
            return false;
        }
    }

    public Optional<User> isAuthenticated(Http.Request request) throws UnsupportedEncodingException {

        Optional<String> authHeader =  request.getHeaders().get("Authorization");
        if (authHeader.filter(ah -> ah.contains("Bearer ")).isEmpty()) {
            return Optional.empty();
        }
        String token = authHeader.get().substring(7);
        if (isValidToken(token)) {
            DecodedJWT decodedJWT = verifier.verify(token);
            Long userID = decodedJWT.getClaim("userId").asLong();
            return usersRepository.findUserById(userID);
        }
        return Optional.empty();
    }
}
