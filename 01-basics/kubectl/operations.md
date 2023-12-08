- **Equality-based**:
  - =, ==, !=
  ```kubectl get pods -l environment=production```
- **Set-based**
  - in, notin, exists
  - ```kubectl get pods -l environment in (production)```